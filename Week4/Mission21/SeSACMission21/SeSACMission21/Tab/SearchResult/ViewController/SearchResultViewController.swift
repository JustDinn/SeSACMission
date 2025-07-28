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
    
    private let queryData = QueryData.shared
    private var searchedResult: [SearchResultModel] = []
    
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
    
    init(keyword: String) {
        queryData.keyword = keyword
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchKeyword(keyword: queryData.keyword, sort: queryData.sort)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setViewController()
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set ViewController
    
    func setViewController() {
        setNaviBar(queryData.keyword)
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
        let selectedFilter = Sort.filters[sender.tag].sort
        
        queryData.sort = selectedFilter
        queryData.pageNumber = 1
        searchedResult.removeAll()
        searchKeyword(keyword: queryData.keyword, sort: queryData.sort, isScrollToTop: true)
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
    
    // 셀 미리 보여주기
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let index = indexPath.item
        
        if index == searchedResult.count - 6 {
            queryData.pageNumber += 1
            searchKeyword(keyword: queryData.keyword, sort: queryData.sort)
        }
    }
}

// MARK: - API Calling

extension SearchResultViewController {
    
    // 네이버 쇼핑 검색 API Get 요청
    private func searchKeyword(keyword: String, sort: String, isScrollToTop: Bool = false) {
        guard let searchURL = makeURL(sort: sort, pageNumber: queryData.pageNumber) else {
            print("<< url 생성 실패")
            return
        }
        
        AF.request(searchURL, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Search.self) { response in
                switch response.result {
                case .success(let searchResult):
                    // 첫 API 호출시에만 마지막 페이지 개수 계산
                    if self.queryData.lastPage == nil {
                        self.queryData.lastPage = Int(ceil(Double(searchResult.totalCount) / Double(self.queryData.pageSize)))
                    }
                    
                    // 최대 페이지 설정
                    if let lastPage = self.queryData.lastPage {
                        let pageNumber = self.queryData.pageNumber
                        
                        if pageNumber <= min(lastPage, 1000) {
                            self.searchedResult.append(contentsOf: searchResult.items)
                            // TODO: API 호출과 UI 업데이트 강한 결합. 분리하기?
                            self.updateUI(searchedResult: searchResult, isScrollToTop: isScrollToTop)
                        }
                    }
                    
                case .failure(let error):
                    print("<< 검색 error: \(error.localizedDescription)")
                }
            }
    }
    
    // 요청 URL 생성
    private func makeURL(sort: String, pageNumber: Int) -> URL? {
        guard var urlComponents = URLComponents(string: "https://openapi.naver.com/v1/search/shop.json") else {
            print("<< urlComponents 생성 실패")
            return nil
        }
        
        let keyword = URLQueryItem(name: "query", value: queryData.keyword)
        let pageSize = URLQueryItem(name: "display", value: queryData.pageSize.formatted())
        let sort = URLQueryItem(name: "sort", value: sort)
        let pageNumber = URLQueryItem(name: "start", value: pageNumber.formatted())
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
    
    // API 호출 후 UI 업데이트
    private func updateUI(searchedResult: Search, isScrollToTop: Bool) {
        DispatchQueue.main.async {
            self.resultLabel.text = "\(searchedResult.totalCount)개의 검색 결과"
            
            // 애니메이션 효과 없이 새로고침
            UIView.performWithoutAnimation {
                self.resultCollectionView.reloadData()
            }
            
            // 정렬 조건 바꾸는 경우
            if isScrollToTop {
                self.resultCollectionView.scrollToItem(
                    at: IndexPath(item: 0, section: 0),
                    at: .top,
                    animated: false
                )
            }
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
