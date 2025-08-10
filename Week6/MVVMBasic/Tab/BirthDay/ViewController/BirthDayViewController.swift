//
//  BirthDayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit
import Then

final class BirthDayViewController: UIViewController {
    
    // MARK: - Property
    
    private let birthDayViewModel = BirthDayViewModel()
    
    // MARK: - Component
    
    private let yearTextField = UITextField().then {
        $0.placeholder = "년도를 입력해주세요"
        $0.borderStyle = .roundedRect
    }
    
    private let yearLabel = UILabel().then {
        $0.text = "년"
    }
    
    private let monthTextField = UITextField().then {
        $0.placeholder = "월을 입력해주세요"
        $0.borderStyle = .roundedRect
    }
    
    private let monthLabel = UILabel().then {
        $0.text = "월"
    }
    
    private let dateTextField = UITextField().then {
        $0.placeholder = "일을 입력해주세요"
        $0.borderStyle = .roundedRect
    }
    
    private let dateLabel = UILabel().then {
        $0.text = "일"
    }
    
    private lazy var resultButton = UIButton().then {
        $0.backgroundColor = .systemBlue
        $0.setTitle( "클릭", for: .normal)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    private let resultLabel = UILabel().then {
        $0.text = "여기에 결과를 보여주세요"
        $0.textAlignment = .center
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        bindClosure()
    }
    
    // MARK: - Set Hierarchy
    
    func configureHierarchy() {
        view.addSubview(yearTextField)
        view.addSubview(yearLabel)
        view.addSubview(monthTextField)
        view.addSubview(monthLabel)
        view.addSubview(dateTextField)
        view.addSubview(dateLabel)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    // MARK: - Set Constraints
    
    func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearTextField)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthTextField)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateTextField)
            make.leading.equalTo(dateTextField.snp.trailing).offset(12)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
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
        birthDayViewModel.year = yearTextField.text
        birthDayViewModel.month = monthTextField.text
        birthDayViewModel.date = dateTextField.text
        
        view.endEditing(true)
    }
    
    // MARK: - Bind Closure
    
    private func bindClosure() {
        birthDayViewModel.result = { message in
            self.resultLabel.text = message
        }
    }
}
