//
//  NetworkRouter.swift
//  SeSACMission21
//
//  Created by HyoTaek on 8/13/25.
//

import Foundation
import Alamofire

enum NetworkRouter {
    case search(String, Int, String, Int)
    
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
}
