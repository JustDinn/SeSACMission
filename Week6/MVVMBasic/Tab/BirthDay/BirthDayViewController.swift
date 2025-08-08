//
//  BirthDayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit
import Then

private enum DateError: Error {
    case notIntYear
    case outOfYear
    case notIntMonth
    case outOfMonth
    case notIntDate
    case outOfDate
}

final class BirthDayViewController: UIViewController {
    
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
        do {
            try isValidDate()
            let inputDate = "\(yearTextField.text!).\(monthTextField.text!).\(dateTextField.text!)"
            guard let toDate = inputDate.toDate() else {
                return
            }
            let dateGap = dateGap(toDate: toDate)
            
            resultLabel.text = "오늘 날짜 기준으로 \(dateGap)일째입니다"
        } catch {
            switch error {
            case .notIntYear:
                resultLabel.text = "입력한 연도를 정수로 변환할 수 없음"
            case .outOfYear:
                resultLabel.text = "입력 가능한 연도의 범위를 벗어남"
            case .notIntMonth:
                resultLabel.text = "입력한 월을 정수로 변환할 수 없음"
            case .outOfMonth:
                resultLabel.text = "입력 가능한 월의 범위를 벗어남"
            case .notIntDate:
                resultLabel.text = "입력한 일을 정수로 변환할 수 없음"
            case .outOfDate:
                resultLabel.text = "입력 가능한 일의 범위를 벗어남"
            }
        }
        
        view.endEditing(true)
    }
    
    // MARK: - 날짜 유효성 검사
    
    @discardableResult
    private func isValidDate() throws(DateError) -> Bool {
        guard let year = yearTextField.text,
              let month = monthTextField.text,
              let date = dateTextField.text else {
            return false
        }
        
        // 연도 유효성 검사
        if Int(year) == nil {
            throw .notIntYear
        }
        
        if Int(year)! < 0 {
            throw .outOfYear
        }
        
        // 월 유효성 검사
        if Int(month) == nil {
            throw .notIntMonth
        }
        
        // 범위 비교는 한개와 비교하기 때문에 시간복잡도가 O(1)이지만, contains는 배열의 모두와 비고하기 떄문에 시간복잡도가 O(1)보다 큼.
        // 코드 시간복잡도 개선
        if Int(month)! < 1 && Int(month)! > 12 {
            throw .outOfMonth
        }
//        if !(1...12).contains(Int(month)!) {
//            throw .outOfMonth
//        }
        
        // 일 유효성 검사
        if Int(date) == nil {
            throw .notIntDate
        }
        
        switch Int(month)! {
        case 1, 3, 5, 7, 8, 10, 12:
            if !(1...31).contains(Int(date)!) {
                throw .outOfDate
            }
        case 4, 6, 9, 11:
            if !(1...30).contains(Int(date)!) {
                throw .outOfDate
            }
        case 2:
            if isLeapYear(Int(year)!) && !(1...29).contains(Int(date)!) {
                throw .outOfDate
            } else if !isLeapYear(Int(year)!) && !(1...28).contains(Int(date)!) {
                throw .outOfDate
            }
        default:
            return false
        }
        return true
    }
    
    // MARK: - 윤년 판별
    
    func isLeapYear(_ year: Int) -> Bool {
        
        if year % 400 == 0 {
            return true
        } else if year % 100 != 0 && year % 4 == 0 {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - 날짜 차이 구하기
    
    func dateGap(toDate: Date) -> Int {
        let calendar = Calendar.current
        
        let toDate = calendar.startOfDay(for: toDate)
        let today = calendar.startOfDay(for: .now)
        
        let gap = calendar.dateComponents([.day], from: today, to: toDate).day ?? 0
        
        return gap
    }
}
