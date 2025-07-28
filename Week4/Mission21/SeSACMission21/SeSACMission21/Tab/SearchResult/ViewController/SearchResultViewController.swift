//
//  SearchResultViewController.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import UIKit
import Alamofire
import Then

final class SearchResultViewController: UIViewController, InitialSetProtocol {

    // MARK: - Properties
    
    private var searchedResult: [SearchResultModel] = []
    private let keyword: String
    
    // MARK: - Component
    
    private let resultLabel = UILabel().then {
        $0.setLabelUI("", size: 15, weight: .semibold, color: .systemGreen)
    }
    
    private let filterScrollView = UIScrollView()
    
    private let filterStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
    }
    
    private lazy var resultCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 16 * 2 - 16) / 2
        let height = CGFloat(280)
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 28
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: width, height: height)
        
        $0.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self
        $0.collectionViewLayout = layout
        $0.backgroundColor = .black
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setViewController()
        setHierarchy()
        setConstraints()
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
    
    func setViewController() {
        setNaviBar(keyword)
        view.backgroundColor = .black
    }
    
    // MARK: - Set Hierarchy
    
    func setHierarchy() {
        [
            resultLabel,
            filterScrollView,
            resultCollectionView
        ].forEach(view.addSubview)
        
        [
            filterStackView
        ].forEach(filterScrollView.addSubview)
        
        makeFilterStackView()
    }
    
    // MARK: - Set Constraints
    
    func setConstraints() {
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        filterScrollView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        filterStackView.snp.makeConstraints {
            $0.edges.equalTo(filterScrollView.contentLayoutGuide)
            $0.height.equalTo(filterScrollView)
        }
        
        resultCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterScrollView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Action
    
    @objc private func didTapFilterButton(_ sender: UIButton) {
        
    }
}

// MARK: - UICollectionView DataSource, Delegate

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // 섹션당 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedResult.count
    }
    
    // 셀 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        let item = indexPath.item
        
        cell.configureCell(with: searchedResult[item])
        
        return cell
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
                    self.updateUI(searchedResult: searchResult)
                    
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
        let displayCount = URLQueryItem(name: "display", value: "30")
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
    
    // API 호출 후 UI 업데이트
    private func updateUI(searchedResult: Search) {
        DispatchQueue.main.async {
            self.resultLabel.text = "\(searchedResult.totalCount)개의 검색 결과"
            self.resultCollectionView.reloadData()
        }
    }
}

// MARK: - 스택뷰 생성

extension SearchResultViewController {
    
    // 필터 스택뷰 생성 함수
    private func makeFilterStackView() {
        
        for (index, filter) in Sort.filters.enumerated() {
            let filterButton = UIButton().then {
                $0.setTitle(filter.title, for: .normal)
                $0.setTitleColor(.white, for: .normal)
                $0.layer.cornerRadius = 10
                $0.layer.masksToBounds = true
                $0.layer.borderColor = UIColor.white.cgColor
                $0.layer.borderWidth = 1
            }
            
            filterButton.snp.makeConstraints {
                $0.width.equalTo(100)
                $0.height.equalTo(44)
            }
            
            filterButton.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
            filterButton.tag = index
            
            filterStackView.addArrangedSubview(filterButton)
        }
    }
}
