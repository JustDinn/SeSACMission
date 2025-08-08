//
//  BMIViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

private enum BMIValidError: Error {
    case isNotIntHeight
    case outOfHeight
    case isNotIntWeight
    case outOfWeight
}

class BMIViewController: UIViewController {
    
    private var bmi: String {
        let height = (Double(heightTextField.text!) ?? 0) / 100
        let weight = Double(weightTextField.text!) ?? 0
        
        return String(format: "%.2f", weight / (height * height))
    }
    
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        do {
            try isValidBMI()
            resultLabel.text = "BMI: \(bmi)"
        } catch {
            switch error {
            case .isNotIntHeight:
                showAlert(title: "경고", message: "키에는 정수를 입력해야합니다")
            case .outOfHeight:
                showAlert(title: "경고", message: "입력한 키가 정말 맞습니까?")
            case .isNotIntWeight:
                showAlert(title: "경고", message: "체중에는 정수를 입력해야합니다")
            case .outOfWeight:
                showAlert(title: "경고", message: "입력한 체중이 정말 맞습니까?")
            }
        }
        view.endEditing(true)
    }
    
    //MARK: - BMI 유효성 검사
    
    @discardableResult
    private func isValidBMI() throws(BMIValidError) -> Bool {
        guard let height = heightTextField.text,
              let weight = weightTextField.text else {
            return false
        }
        
        if Int(height) == nil {
            throw .isNotIntHeight
        }
        
        if !(100...200).contains(Int(height)!) {
            throw .outOfHeight
        }
        
        if Int(weight) == nil {
            throw .isNotIntWeight
        }
        
        if !(20...200).contains(Int(weight)!) {
            throw .outOfWeight
        }
        
        return true
    }
}
