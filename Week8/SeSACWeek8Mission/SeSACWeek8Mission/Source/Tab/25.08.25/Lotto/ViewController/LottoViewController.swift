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
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
            .flatMap { LottoObservable.getLottoNumber(query: $0) }
            .subscribe(with: self) { owner, lottoInfo in
                owner.resultLabel.text = "\(lottoInfo.first) \(lottoInfo.second) \(lottoInfo.third) \(lottoInfo.fourth) \(lottoInfo.fifth) \(lottoInfo.sixth) \(lottoInfo.bonus)"
            } onError: { owner, error in
                print("<< error: \(error)")
            } onCompleted: { owner in
                print("<< onCompleted")
            } onDisposed: { owner in
                print("<< onDisposed")
            }
            .disposed(by: disposeBag)
    }
}
