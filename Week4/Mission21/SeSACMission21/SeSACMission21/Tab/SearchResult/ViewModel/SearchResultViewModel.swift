//
//  SearchResultViewModel.swift
//  SeSACMission21
//
//  Created by HyoTaek on 8/13/25.
//

import Foundation

final class SearchResultViewModel {
    
    // MARK: - Singleton
    
    private let networkManager = NetworkManager.shared
    private let queryData = QueryData.shared
    
    // MARK: - Observable
    
    // Input
    struct Input {
        var keyword: Observable<String> = Observable("")
        var pageNumber: Observable<Int> = Observable(1)
        var retry: Observable<Bool> = Observable(false)
        var reset: Observable<Bool> = Observable(false)
        var filterSearch: Observable<Int> = Observable(0)
    }
    var input = Input()
    
    // Output
    struct Output {
        var searchedResult: Observable<[SearchResultModel]> = Observable([])
        var recommendResult: Observable<[SearchResultModel]> = Observable([])
        var searchedCount: Observable<Int> = Observable(0)
        var errorMessage: Observable<String> = Observable("")
    }
    var output = Output()
    
    // MARK: - Init
    
    init() {
        input.keyword.lazyBind { [weak self] keyword in
            guard let self = self else { return }
            
            queryData.keyword = keyword
            searchKeyword(queryData: queryData)
            searchKeyword(queryData: queryData, isRecommendSearching: true)
        }
        
        input.pageNumber.lazyBind { [weak self] pageNumber in
            guard let self = self else { return }
            
            queryData.pageNumber = pageNumber
            searchKeyword(queryData: queryData)
        }
        
        input.retry.lazyBind { [weak self] _ in
            guard let self = self else { return }
            
            searchKeyword(queryData: queryData)
            searchKeyword(queryData: queryData, isRecommendSearching: true)
        }
        
        input.reset.lazyBind { [weak self] _ in
            guard let self = self else { return }
            
            queryData.reset()
        }
        
        input.filterSearch.lazyBind { [weak self] filterID in
            guard let self = self else { return }
            let selectedFilter = Sort.filters[filterID].sort
            
            queryData.sort = selectedFilter
            queryData.pageNumber = 1
            output.searchedResult.value.removeAll()
            searchKeyword(queryData: queryData, isScrollToTop: true)
        }
    }
    
    // MARK: - API Calling
    
    // 네이버 쇼핑 검색 API Get 요청
    private func searchKeyword(queryData: QueryData, isScrollToTop: Bool = false, isRecommendSearching: Bool = false) {
        
        // 검색 기록 추가
        queryData.searchedHistory.insert(queryData.keyword)
        
        let query = isRecommendSearching
                        ? queryData.keyword
                        : queryData.searchedHistory.randomElement() ?? "가오리"
        
        // 네이버 쇼핑 검색 API 호출
        networkManager.networkRequest(
            api: .search(
                query: query,
                pageSize: queryData.pageSize.formatted(),
                sort: queryData.sort,
                pageNumber: queryData.pageNumber.formatted()
            ),
            isRecommendSearching: isRecommendSearching,
            model: Search.self) { result in
                switch result {
                case .success(let searchedResult):
                    // 첫 API 호출시에만 마지막 페이지 개수 계산
                    if self.queryData.lastPage == nil {
                        self.queryData.lastPage = Int(ceil(Double(searchedResult.totalCount) / Double(self.queryData.pageSize)))
                    }
                    self.output.searchedCount.value = searchedResult.totalCount
                    
                    // 최대 페이지 설정
                    if let lastPage = self.queryData.lastPage {
                        let pageNumber = self.queryData.pageNumber
                        
                        if pageNumber <= min(lastPage, 1000) {
                            if isRecommendSearching {
                                self.output.recommendResult.value.append(contentsOf: searchedResult.items)
                            } else {
                                self.output.searchedResult.value.append(contentsOf: searchedResult.items)
                            }
                        }
                    }
                    
                case .failure(let error):
                    var message: String
                    
                    if let networkError = error as? NetworkError {
                        switch networkError {
                        case .responseFail(let statusCode, let errorMessage):
                            print("<< 네이버 쇼핑 검색 API 응답 실패 - 상태코드: \(statusCode), 메시지: \(errorMessage ?? "없음")")
                            
                            switch statusCode {
                            case 400:
                                print("<< 네이버 쇼핑 검색 API: 잘못된 요청")
                                message = "[\(statusCode)] 잘못된 요청입니다"
                                
                            case 401:
                                print("<< 네이버 쇼핑 검색 API: 인증 실패")
                                message = "[\(statusCode)] 인증 실패(API Key, Cliend ID 누락 혹은 만료)"
                                
                            case 403:
                                print("<< 네이버 쇼핑 검색 API: 접근 거부")
                                message = "[\(statusCode)] 접근 거부"
                                
                            case 404:
                                print("<< 네이버 쇼핑 검색 API: 찾을 수 없음")
                                message = "[\(statusCode)] 서버 찾을 수 없음"
                                
                            case 500...599:
                                print("<< 네이버 쇼핑 검색 API: 서버 오류")
                                message = "[\(statusCode)] 서버 에러"
                                
                            default:
                                print("<< 네이버 쇼핑 검색 API: 기타 오류")
                                message = "[\(statusCode)] 기타 에러"
                            }
                            
                        case .decodingFailed(let errorMessage):
                            print("<< 네이버 쇼핑 검색 API: 디코딩 실패 \(errorMessage)")
                            message = "디코딩 에러"
                            
                        case .unknownError:
                            print("<< 알 수 없는 네트워크 에러")
                            message = "알 수 없는 네트워크 에러"
                        }
                    } else {
                        print("<< 알 수 없는 에러: \(error.localizedDescription)")
                        message = "알 수 없는 에러"
                    }
                    self.output.errorMessage.value = message
                }
        }
    }
}
