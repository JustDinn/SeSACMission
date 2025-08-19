//
//  AddingNumbersViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/20/25.
//

import UIKit
import SnapKit
import Then

final class AddingNumbersViewController: UIViewController {
    
    // MARK: - Component
    
    private let firstNumber = UITextField().then {
        $0.keyboardType = .numberPad
        $0.textAlignment = .right
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let secondNumber = UITextField().then {
        $0.keyboardType = .numberPad
        $0.textAlignment = .right
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let thirdNumber = UITextField().then {
        $0.keyboardType = .numberPad
        $0.textAlignment = .right
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let plusIcon = UIImageView().then {
        $0.image = UIImage(systemName: "plus")
        $0.tintColor = .black
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
            firstNumber,
            secondNumber,
            thirdNumber,
            plusIcon
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        firstNumber.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
        
        secondNumber.snp.makeConstraints {
            $0.top.equalTo(firstNumber.snp.bottom).offset(20)
            $0.size.horizontalEdges.equalTo(firstNumber)
        }
        
        thirdNumber.snp.makeConstraints {
            $0.top.equalTo(secondNumber.snp.bottom).offset(20)
            $0.size.horizontalEdges.equalTo(firstNumber)
        }
        
        plusIcon.snp.makeConstraints {
            $0.trailing.equalTo(thirdNumber.snp.leading).offset(-20)
            $0.centerY.equalTo(thirdNumber)
        }
    }
}
