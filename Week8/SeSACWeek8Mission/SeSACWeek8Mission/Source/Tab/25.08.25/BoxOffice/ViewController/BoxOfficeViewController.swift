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
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Component
    
    private let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.placeholder = "날짜 검색"
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
            searchBar
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
            .flatMap { BoxOfficeObservable.getBoxOfficeInfo(query: $0) }
            .subscribe(with: self) { owner, boxOfficeInfo in
                print("<< 정보: \(boxOfficeInfo)")
            } onError: { owner, error in
                print("<< 에러: \(error)")
            } onCompleted: { owner in
                print("<< onCompleted")
            } onDisposed: { owner in
                print("<< onDisposed")
            }
            .disposed(by: disposeBag)
    }
}
