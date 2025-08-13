//
//  NetworkRouter.swift
//  SeSACMission21
//
//  Created by HyoTaek on 8/13/25.
//

import Foundation
import Alamofire

enum NetworkRouter {
    case search(query: String, pageSize: String, sort: String, pageNumber: String)
    
    // MARK: - Base URL
    
    var baseURL: String {
        guard let url = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            return ""
        }
        return url
    }
    
    // MARK: - Endpoint
    
    var endpoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/shop.json")!
        }
    }
    
    // MARK: - Method
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    // MARK: - Parameters
    
    var parameters: Parameters {
        switch self {
        case .search(let query, let pageSize, let sort, let pageNumber):
            return [
                "query": query,
                "display": pageSize,
                "sort": sort,
                "start": pageNumber
            ]
        }
    }
    
    // MARK: - Headers
    
    // 요청 헤더 설정
    var headers: HTTPHeaders {
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
