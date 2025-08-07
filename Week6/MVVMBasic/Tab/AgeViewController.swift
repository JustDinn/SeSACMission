//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit
import Then

enum AgeValidError: Error {
    case empty
    case notInt
    case outOfRange
}

final class AgeViewController: UIViewController {
    
    // MARK: - Component
    
    private let textField = UITextField().then {
        $0.placeholder = "나이를 입력해주세요"
        $0.borderStyle = .roundedRect
        $0.keyboardType = .phonePad
    }
    
    private lazy var resultButton = UIButton().then {
        $0.backgroundColor = .systemBlue
        $0.setTitle( "클릭", for: .normal)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    private let label = UILabel().then {
        $0.text = "여기에 결과를 보여주세요"
        $0.textAlignment = .center
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
    }
    
    // MARK: - Set Hierarchy
    
    private func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(label)
    }
    
    // MARK: - Set Constraints
    
    private func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    // MARK: - Action
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        do {
            try isValidAge()
            label.text = "나이 유효성 검사 통과: \(textField.text!)"
        } catch {
            switch error {
            case .empty:
                label.text = "나이 입력 비었음"
            case .notInt:
                label.text = "나이 정수 변환 실패"
            case .outOfRange:
                label.text = "인간의 나이를 벗어난 당신은 외계인👽"
            }
        }
        
        view.endEditing(true)
    }
    
    // MARK: - 나이 유효성 검사
    
    private func isValidAge() throws(AgeValidError) -> Bool {
        guard let age = textField.text else {
            return false
        }
        
        if age.isEmpty {
            throw .empty
        }
        
        if Int(age) == nil {
            throw .notInt
        }
        
        // 위에서 Int(age)를 통과했으므로 강제 언래핑
        if !(1...100).contains(Int(age)!) {
            throw .outOfRange
        }
        
        return true
    }
}
