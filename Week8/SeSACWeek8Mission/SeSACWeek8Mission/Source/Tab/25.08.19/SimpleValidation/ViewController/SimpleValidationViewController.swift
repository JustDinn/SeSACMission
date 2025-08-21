//
//  SimpleValidationViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/20/25.
//

import UIKit
import SnapKit
import Then

import RxSwift
import RxCocoa

final class SimpleValidationViewController: UIViewController {

    // MARK: - DisposeBag
    
    var disposeBag = DisposeBag()
    
    // MARK: - ViewModel
    
    private let simpleValidationViewModel = SimpleValidationViewModel()
    
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
        bind()
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
    
    private func bind() {
        let input = SimpleValidationViewModel.Input(
            usernameText: usernameTextField.rx.text.orEmpty,
            passwordText: passwordTextField.rx.text.orEmpty,
            doneButtonTapped: doneButton.rx.tap
        )
        
        let output = simpleValidationViewModel.transform(input: input)
        
        output.usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.everythingValid
            .bind(to: doneButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.showAlert
            .bind(with: self, onNext: { owner, alertInfo in
                owner.showAlert(title: alertInfo.0, message: alertInfo.1)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Alert
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default)
        
        alertController.addAction(okButton)
        present(alertController, animated: true)
    }
}
