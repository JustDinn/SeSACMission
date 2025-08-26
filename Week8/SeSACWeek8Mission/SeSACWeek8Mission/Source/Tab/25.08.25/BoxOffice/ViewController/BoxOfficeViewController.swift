//
//  BoxOfficeViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class BoxOfficeViewController: UIViewController {

    // MARK: - Property
    
    private let boxOfficeList = BehaviorRelay<[MovieInfo]>(value: [])
    private let disposeBag = DisposeBag()
    private let viewModel = BoxOfficeViewModel()
    
    // MARK: - Component
    
    private let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.placeholder = "날짜 검색"
    }
    
    private let boxOfficeTableView = UITableView().then {
        $0.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.reuseIdentifier)
        $0.backgroundColor = .main
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setHierarchy()
        setConstraints()
        bind()
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            searchBar,
            boxOfficeTableView
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        boxOfficeTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        let input = BoxOfficeViewModel.Input(
            searchButtonTapped: searchBar.rx.searchButtonClicked,
            searchKeyword: searchBar.rx.text.orEmpty
        )
        let output = viewModel.transform(input: input)
        
        output.result
            .bind(to: boxOfficeTableView.rx.items(
                cellIdentifier: BoxOfficeTableViewCell.reuseIdentifier,
                cellType: BoxOfficeTableViewCell.self)) { row, item, cell in
                    cell.configureCell(with: item.title)
                }
            .disposed(by: disposeBag)
        
        output.errorMessage
            .bind(with: self) { owner, errorMessage in
                owner.view.showToast(errorMessage)
            }
            .disposed(by: disposeBag)
        
        output.showAlert
            .bind(with: self) { owner, alertMessage in
                owner.showAlert(title: "네트워크 에러", message: alertMessage)
            }
            .disposed(by: disposeBag)
    }
}
