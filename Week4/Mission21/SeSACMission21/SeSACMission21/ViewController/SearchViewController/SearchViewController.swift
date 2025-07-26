//
//  SearchViewController.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import UIKit
import SnapKit
import Then
import Toast

final class SearchViewController: UIViewController, InitialSetProtocol {

    // MARK: - Component
    
    private lazy var searchBar = UISearchBar().then {
        $0.placeholder = "브랜드, 상품, 프로필, 태그 등"
        $0.barTintColor = .black
        $0.searchTextField.textColor = .white
        $0.searchTextField.setPlaceholderUI(color: .systemGray)
        $0.searchTextField.delegate = self
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

// MARK: - UITextField Delegate

extension SearchViewController: UITextFieldDelegate {

    // returnKey 탭
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isEnablePush {
            searchBar.searchTextField.endEditing(true)
            pushSearchResultVC()
            
            return true
        }
        return false
    }
}

// MARK: - TextField Validate

extension SearchViewController {
    
    // 2글자 이상인지 검증
    private var isEnablePush: Bool {
        if let searchBarText = searchBar.searchTextField.text {
            if searchBarText.trimmingCharacters(in: .whitespacesAndNewlines).count >= 2 {
                return true
            } else {
                let centerX = view.frame.width / 2
                let currentY = view.frame.height * 0.25
                
                self.view.makeToast("2글자 이상 입력해주세요 :D", duration: 1.5, point: CGPoint(x: centerX, y: currentY), title: nil, image: nil){ _ in }
            }
        }
        return false
    }
}
