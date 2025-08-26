//
//  LottoViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class LottoViewController: UIViewController {
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    private let viewModel = LottoViewModel()
    
    // MARK: - Component
    
    private let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.placeholder = "로또 번호 검색"
    }
    
    private let resultLabel = UILabel()
    
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
            resultLabel
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        resultLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        let input = LottoViewModel.Input(
            searchTap: searchBar.rx.searchButtonClicked,
            searchText: searchBar.rx.text.orEmpty
        )
        let output = viewModel.transform(input: input)
        
        output.lottoResult
            .bind(to: resultLabel.rx.text)
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
