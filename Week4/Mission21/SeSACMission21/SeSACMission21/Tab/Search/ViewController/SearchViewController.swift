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

    // MARK: - Property
    
    private let searchViewModel = SearchViewModel()
    
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
        
        setViewController()
        setHierarchy()
        setConstraints()
        bind()
    }
    
    // MARK: - Set UI
    
    func setViewController() {
        view.backgroundColor = .black
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        setBackNaviBar("영캠러의 쇼핑쇼핑")
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
    
    // MARK: - Bind
    
    private func bind() {
        searchViewModel.output.toastMessage.lazyBind { message in
            self.view.showToast(message)
        }
        
        searchViewModel.output.pushingKeyword.lazyBind { keyword in
            self.pushSearchResultVC(keyword: keyword)
        }
    }
    
    // MARK: Action
    
    @objc private func dismissKeyboard() {
        searchBar.searchTextField.endEditing(true)
    }
}

// MARK: - UITextField Delegate

extension SearchViewController: UITextFieldDelegate {

    // returnKey 탭
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchViewModel.input.keyword.value = textField.text
        
        return true
    }
}
