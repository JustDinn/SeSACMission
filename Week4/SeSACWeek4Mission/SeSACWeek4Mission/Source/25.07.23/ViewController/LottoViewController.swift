//
//  LottoViewController.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/23/25.
//

import UIKit
import SnapKit

final class LottoViewController: UIViewController, InitialSetProtocol {

    // MARK: - Component
    
    private let lottoNumberTextField: UITextField = {
        let textField = UITextField()
        
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.textAlignment = .center
        
        return textField
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setAddView()
        setConstraints()
    }
    
    // MARK: - Set UI
    
    func setUI() {
        view.backgroundColor = .white
    }
    
    // MARK: - Set AddView
    
    func setAddView() {
        [
            lottoNumberTextField
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    func setConstraints() {
        lottoNumberTextField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
    }
}
