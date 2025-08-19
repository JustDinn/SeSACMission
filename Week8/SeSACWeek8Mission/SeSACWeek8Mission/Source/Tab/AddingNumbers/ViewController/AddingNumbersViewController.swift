//
//  AddingNumbersViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/20/25.
//

import UIKit
import SnapKit
import Then

import RxSwift
import RxCocoa

final class AddingNumbersViewController: UIViewController {
    
    // MARK: - DisposeBag
    
    var disposeBag = DisposeBag()
    
    // MARK: - Component
    
    private let firstNumber = UITextField().then {
        $0.text = "1"
        $0.keyboardType = .numberPad
        $0.textAlignment = .right
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let secondNumber = UITextField().then {
        $0.text = "2"
        $0.keyboardType = .numberPad
        $0.textAlignment = .right
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let thirdNumber = UITextField().then {
        $0.text = "3"
        $0.keyboardType = .numberPad
        $0.textAlignment = .right
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let plusIcon = UIImageView().then {
        $0.image = UIImage(systemName: "plus")
        $0.tintColor = .black
    }
    
    private let borderLine = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let resultLabel = UILabel().then {
        $0.text = "6"
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
            firstNumber,
            secondNumber,
            thirdNumber,
            plusIcon,
            borderLine,
            resultLabel
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
            $0.top.equalTo(firstNumber.snp.bottom).offset(10)
            $0.size.horizontalEdges.equalTo(firstNumber)
        }
        
        thirdNumber.snp.makeConstraints {
            $0.top.equalTo(secondNumber.snp.bottom).offset(10)
            $0.size.horizontalEdges.equalTo(firstNumber)
        }
        
        plusIcon.snp.makeConstraints {
            $0.trailing.equalTo(thirdNumber.snp.leading).offset(-10)
            $0.centerY.equalTo(thirdNumber)
        }
        
        borderLine.snp.makeConstraints {
            $0.top.equalTo(thirdNumber.snp.bottom).offset(10)
            $0.leading.equalTo(plusIcon)
            $0.trailing.equalTo(thirdNumber)
            $0.height.equalTo(1)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom).offset(10)
            $0.trailing.equalTo(borderLine)
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        Observable.combineLatest(
            firstNumber.rx.text.orEmpty,
            secondNumber.rx.text.orEmpty,
            thirdNumber.rx.text.orEmpty) { firstText, secondText, thirdText -> Int in
                return (Int(firstText) ?? 0) + (Int(secondText) ?? 0) + (Int(thirdText) ?? 0)
            }
            .map { $0.description }
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
