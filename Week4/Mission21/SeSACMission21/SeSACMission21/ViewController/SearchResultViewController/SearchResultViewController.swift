//
//  SearchResultViewController.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import UIKit
import Alamofire

final class SearchResultViewController: UIViewController {

    // MARK: - Properties
    
    private let keyword: String
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(keyword: String) {
        self.keyword = keyword
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - API Calling

extension SearchResultViewController {
    
    // 요청 URL 생성
    private var url: URL? {
        guard var urlComponents = URLComponents(string: "https://openapi.naver.com/v1/search/shop.json") else {
            print("<< urlComponents 생성 실패")
            return nil
        }
        let queryParameter = URLQueryItem(name: "query", value: keyword)
        urlComponents.queryItems = [queryParameter]
        
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
            print("<< cliendID: \(cliendID), secretKey: \(secretKey)")
            return headers
        }
        print("<< cliendID, secretKey 찾을 수 없음")
        return [:]
    }
}
