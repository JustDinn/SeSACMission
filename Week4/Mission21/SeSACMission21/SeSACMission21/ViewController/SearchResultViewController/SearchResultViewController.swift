//
//  SearchResultViewController.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import UIKit

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
}
