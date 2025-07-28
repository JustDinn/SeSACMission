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
    
    private var searchedResult: [SearchResultModel] = []
    private let keyword: String
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchKeyword(keyword: keyword)
    }
    
    init(keyword: String) {
        self.keyword = keyword
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set ViewController
    
    private func setViewController() {
        setNaviBar(keyword)
        view.backgroundColor = .black
    }
}

// MARK: - API Calling

extension SearchResultViewController {
    
    // 네이버 쇼핑 검색 API Get 요청
    private func searchKeyword(keyword: String) {
        guard let searchURL = url else {
            print("<< url 생성 실패")
            return
        }
        
        AF.request(searchURL, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Search.self) { response in
                switch response.result {
                case .success(let searchResult):
                    self.searchedResult = searchResult.items
                    
                case .failure(let error):
                    print("<< 검색 error: \(error.localizedDescription)")
                }
            }
    }
    
    // 요청 URL 생성
    private var url: URL? {
        guard var urlComponents = URLComponents(string: "https://openapi.naver.com/v1/search/shop.json") else {
            print("<< urlComponents 생성 실패")
            return nil
        }
        let keyword = URLQueryItem(name: "query", value: keyword)
        let displayCount = URLQueryItem(name: "display", value: "100")
        urlComponents.queryItems = [keyword, displayCount]
        
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
