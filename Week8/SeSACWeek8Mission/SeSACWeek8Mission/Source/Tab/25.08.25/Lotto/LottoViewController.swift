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
    
    // MARK: - Component
    
    private let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
    }
    
    private let resultLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setConstraints()
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
}
