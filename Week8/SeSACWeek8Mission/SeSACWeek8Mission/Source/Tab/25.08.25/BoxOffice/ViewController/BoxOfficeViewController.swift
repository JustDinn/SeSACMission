//
//  BoxOfficeViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

import UIKit
import SnapKit
import Then

final class BoxOfficeViewController: UIViewController {

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
}
