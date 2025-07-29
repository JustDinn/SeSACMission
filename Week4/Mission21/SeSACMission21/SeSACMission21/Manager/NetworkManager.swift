//
//  NetworkManager.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/29/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    // 네이버 쇼핑 검색 API Get 요청
    func searchKeyword(query: QueryData, isRecommendSearching: Bool = false, completion: @escaping (Search) -> Void) {
        guard let searchURL = makeURL(queryData: query, isRecommendSearching: isRecommendSearching) else {
            print("<< url 생성 실패")
            return
        }
        
        AF.request(searchURL, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Search.self) { response in
                switch response.result {
                case .success(let searchResult):
                    completion(searchResult)
                    
                case .failure(let error):
                    print("<< 검색 error: \(error.localizedDescription)")
                }
            }
    }
    
    // 요청 URL 생성
    private func makeURL(queryData: QueryData, isRecommendSearching: Bool) -> URL? {
        guard var urlComponents = URLComponents(string: "https://openapi.naver.com/v1/search/shop.json") else {
            print("<< urlComponents 생성 실패")
            return nil
        }
        
        let keyword = isRecommendSearching
                        ? URLQueryItem(name: "query", value: queryData.searchedHistory.randomElement() ?? "가오리")
                        : URLQueryItem(name: "query", value: queryData.keyword)
        let pageSize = URLQueryItem(name: "display", value: queryData.pageSize.formatted())
        let sort = URLQueryItem(name: "sort", value: queryData.sort)
        let pageNumber = URLQueryItem(name: "start", value: queryData.pageNumber.formatted())
        urlComponents.queryItems = [keyword, pageSize, sort, pageNumber]
        
        return urlComponents.url
    }
    
    // 요청 헤더 설정
    private var headers: HTTPHeaders {
        if let cliendID = Bundle.main.infoDictionary?["SHOPPING_CLIENT_ID"] as? String,
           let secretKey = Bundle.main.infoDictionary?["SHOPPING_SECRET_KEY"] as? String {
            let headers: HTTPHeaders = [
                "X-Naver-Client-Id": cliendID,
                "X-Naver-Client-Secret": secretKey
            ]
            return headers
        }
        print("<< cliendID, secretKey 찾을 수 없음")
        return [:]
    }
}
