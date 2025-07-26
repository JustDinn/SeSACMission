//
//  SearchViewController.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import UIKit
import SnapKit
import Then

final class SearchViewController: UIViewController, InitialSetProtocol {

    // MARK: - Component
    
    private let searchBar = UISearchBar().then {
        $0.placeholder = "브랜드, 상품, 프로필, 태그 등"
        $0.searchTextField.setPlaceholderUI(color: .systemGray)
        $0.barTintColor = .black
    }
    
    private let defaultImageView = UIImageView().then {
        $0.image = UIImage(systemName: "cart")
        $0.tintColor = .white
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Set UI
    
    func setUI() {
        view.backgroundColor = .black
        setNaviBar("영캠러의 쇼핑쇼핑")
    }
    
    // MARK: - Set Hierarchy
    
    func setHierarchy() {
        [
            searchBar,
            defaultImageView
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        defaultImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(250)
        }
    }
}
