//
//  SimpleValidationViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/20/25.
//

import UIKit
import SnapKit
import Then

final class SimpleValidationViewController: UIViewController {

    // MARK: - Component
    
    private let usernameLabel = UILabel().then {
        $0.text = "Username"
    }
    
    private let usernameTextField = UITextField().then {
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let usernameValidLabel = UILabel().then {
        $0.text = "이름은 최소 5글자 이상이어야 합니다"
        $0.textColor = .systemRed
    }
    
    private let passwordLabel = UILabel().then {
        $0.text = "Password"
    }
    
    private let passwordTextField = UITextField().then {
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let passwordValidLabel = UILabel().then {
        $0.text = "비밀번호는 최소 5글자 이상이어야 합니다"
        $0.textColor = .systemRed
    }
    
    private let doneButton = UIButton().then {
        $0.backgroundColor = .systemBlue
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            usernameLabel,
            usernameTextField,
            usernameValidLabel,
            passwordLabel,
            passwordTextField,
            passwordValidLabel,
            doneButton
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalToSuperview().offset(16)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        usernameValidLabel.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(usernameValidLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        passwordValidLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        
        doneButton.snp.makeConstraints {
            $0.top.equalTo(passwordValidLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
}
