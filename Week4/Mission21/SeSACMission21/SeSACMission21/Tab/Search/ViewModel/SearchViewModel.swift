//
//  SearchViewModel.swift
//  SeSACMission21
//
//  Created by HyoTaek on 8/12/25.
//

import Foundation

final class SearchViewModel {
    
    // MARK: - Observable
    
    var input: Observable<String?> = Observable("")
    var output: Observable<String> = Observable("")
    var message = ""
    
    // MARK: - Init
    
    init() {
        input.lazyBind { [weak self] keyword in
            guard let self = self else { return }
            
            do {
                try self.isEnablePush(keyword: keyword)
                message = "환영합니다 :D"
            } catch let error as SearchError {
                switch error {
                case .unknownError:
                    message = "알 수 없는 에러 발생"
                case .underTextCount:
                    message = "2글자 이상 입력해주세요 :D"
                }
            } catch {
                message = "예외 상황 발생"
            }
            output.value = message
        }
    }
    
    // MARK: - 검색어 유효성 검증
    
    // 2글자 이상인지 검증
    @discardableResult
    private func isEnablePush(keyword: String?) throws(SearchError) -> Bool {
        
        // 옵셔널 바인딩 실패
        guard let keyword = keyword?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            throw .unknownError
        }
        
        // 검색 키워드가 2글자 미만인 경우
        if keyword.count < 2 {
            throw .underTextCount
        }
        
        return true
    }
}
