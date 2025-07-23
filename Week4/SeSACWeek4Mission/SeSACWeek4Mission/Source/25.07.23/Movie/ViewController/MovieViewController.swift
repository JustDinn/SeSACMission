//
//  MovieViewController.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/24/25.
//

import UIKit
import SnapKit

final class MovieViewController: UIViewController, InitialSetProtocol {

    // MARK: - Component
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "영화 검색"
        textField.textColor = .white
        
        return textField
    }()
    
    private let separatingLine = SeparatingLine(color: .white)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setAddView()
        setConstraints()
    }
    
    // MARK: - Set UI
    
    func setUI() {
        view.backgroundColor = .black
    }
    
    func setAddView() {
        [
            searchTextField,
            separatingLine
        ].forEach(view.addSubview)
    }
    
    func setConstraints() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(UIScreen.main.bounds.width * 0.7)
            $0.height.equalTo(44)
        }
        
        separatingLine.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom)
            $0.width.equalTo(searchTextField)
            $0.height.equalTo(1)
        }
    }
}
