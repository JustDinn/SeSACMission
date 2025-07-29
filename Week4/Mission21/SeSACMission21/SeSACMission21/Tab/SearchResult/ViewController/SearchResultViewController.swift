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
    
    private let networkManager = NetworkManager.shared
    private let queryData = QueryData.shared
    private var searchedResult: [SearchResultModel] = []
    private var recommendResult: [SearchResultModel] = []
    
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
    
    private lazy var recommendCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 80, height: 80)
        
        $0.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .black
    }
    
    // MARK: - Life Cycle
    
    init(keyword: String) {
        queryData.keyword = keyword
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchKeyword(queryData: queryData)
        searchKeyword(queryData: queryData, isRecommendSearching: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setViewController()
        setHierarchy()
        setConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        queryData.reset()
    }
    
    @available(*, unavailable)
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
            resultCollectionView,
            recommendCollectionView
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(90)
        }
        
        recommendCollectionView.snp.makeConstraints {
            $0.top.equalTo(resultCollectionView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Action
    
    @objc private func didTapFilterButton(_ sender: UIButton) {
        let selectedFilter = Sort.filters[sender.tag].sort
        
        queryData.sort = selectedFilter
        queryData.pageNumber = 1
        searchedResult.removeAll()
        searchKeyword(queryData: queryData, isScrollToTop: true)
    }
}

// MARK: - UICollectionView DataSource, Delegate

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // 섹션당 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == resultCollectionView {
            return searchedResult.count
        } else if collectionView == recommendCollectionView {
            return recommendResult.count
        } else {
            fatalError("collectionView 찾을 수 없음")
        }
    }
    
    // 셀 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == resultCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
            let item = indexPath.item
            
            cell.configureCell(with: searchedResult[item])
            
            return cell
        } else if collectionView == recommendCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as! RecommendCollectionViewCell
            let item = indexPath.item
            
            cell.configureCell(with: recommendResult[item])
            
            return cell
        } else {
            fatalError("collectionView 찾을 수 없음")
        }
    }
    
    // 셀 미리 보여주기
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == resultCollectionView {
            let index = indexPath.item
            
            if index == searchedResult.count - 6 {
                queryData.pageNumber += 1
                searchKeyword(queryData: queryData)
            }
        }
    }
}

// MARK: - API Calling

extension SearchResultViewController {
    
    // 네이버 쇼핑 검색 API Get 요청
    
    private func searchKeyword(queryData: QueryData, isScrollToTop: Bool = false, isRecommendSearching: Bool = false) {
        
        // 검색 기록 추가
        queryData.searchedHistory.insert(queryData.keyword)
        
        // 네이버 쇼핑 검색 API 호출
        networkManager.searchKeyword(query: queryData, isRecommendSearching: isRecommendSearching) { result in
            
            // 첫 API 호출시에만 마지막 페이지 개수 계산
            if self.queryData.lastPage == nil {
                self.queryData.lastPage = Int(ceil(Double(result.totalCount) / Double(self.queryData.pageSize)))
            }
            
            // 최대 페이지 설정
            if let lastPage = self.queryData.lastPage {
                let pageNumber = self.queryData.pageNumber
                
                if pageNumber <= min(lastPage, 1000) {
                    // TODO: API 호출과 UI 업데이트 강한 결합. 분리하기?
                    if isRecommendSearching {
                        self.recommendResult.append(contentsOf: result.items)
                        self.updateUI(searchedResult: result, isRecommendSearching: true, isScrollToTop: isScrollToTop)
                    } else {
                        self.searchedResult.append(contentsOf: result.items)
                        self.updateUI(searchedResult: result, isScrollToTop: isScrollToTop)
                    }
                }
            }
        }
    }
    
    // API 호출 후 UI 업데이트
    private func updateUI(searchedResult: Search, isRecommendSearching: Bool = false, isScrollToTop: Bool) {
        DispatchQueue.main.async {
            self.resultLabel.text = "\(searchedResult.totalCount)개의 검색 결과"
            
            if isRecommendSearching{
                // 애니메이션 효과 없이 새로고침
                UIView.performWithoutAnimation {
                    self.recommendCollectionView.reloadData()
                }
            } else {
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
