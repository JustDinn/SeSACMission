//
//  NetworkRouter.swift
//  SeSACMission21
//
//  Created by HyoTaek on 8/13/25.
//

import Foundation
import Alamofire

enum NetworkRouter {
    case search
    
    var baseURL: String {
        guard let url = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            return ""
        }
        return url
    }
    
    var endpoint: URL {
        switch self {
        case .search:
            return URL(string: "search/shop.json")!
        }
    }
}
