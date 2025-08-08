//
//  CurrencyViewController.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/5/25.
//

import UIKit
import SnapKit
import Then

final class CurrencyViewController: UIViewController {
    
    // MARK: - Component
    
    private let exchangeRateLabel = UILabel().then { label in
        label.text = "현재 환율: 1 USD = 1,350 KRW"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "원화 금액을 입력하세요"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        return textField
    }()
    
    private lazy var convertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("환전하기", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(convertButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "환전 결과가 여기에 표시됩니다"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
     
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
     
    // MARK: - Set UI
    private func setupUI() {
        view.backgroundColor = .white
        
        [
            exchangeRateLabel,
            amountTextField,
            convertButton,
            resultLabel
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setupConstraints() {
        exchangeRateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        convertButton.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(convertButton.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Action
     
    @objc private func convertButtonTapped() {
        guard let amountText = amountTextField.text,
              let amount = Double(amountText) else {
            resultLabel.text = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        resultLabel.text = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
