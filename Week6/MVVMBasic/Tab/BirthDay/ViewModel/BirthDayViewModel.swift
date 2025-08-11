//
//  BirthDayViewModel.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/9/25.
//

import Foundation

final class BirthDayViewModel {
    
    // MARK: - Property
    
    var message = ""
    
    // MARK: - Observable
    
    var year = Observable("")
    var month = Observable("")
    var date = Observable("")
    var output = Observable("")
    
    // MARK: - Init
    
    init() {
        year.bind { _ in
            self.updateMessage()
        }
        
        month.bind { _ in
            self.updateMessage()
        }
        
        date.bind { _ in
            self.updateMessage()
        }
    }
    
    // MARK: - Message Update
    
    private func updateMessage() {
        do {
            try isValidDate()
            
            let inputText = "\(year.value).\(month.value).\(date.value)"
            guard let toDate = inputText.toDate() else {
                return
            }
            let dateGap = dateGap(toDate: toDate)
            
            message = "오늘 날짜 기준으로 \(dateGap)일째입니다"
        } catch {
            switch error {
            case .isEmptyYear:
                message = "연도의 입력값이 비었음"
            case .notIntYear:
                message = "입력한 연도를 정수로 변환할 수 없음"
            case .outOfYear:
                message = "입력 가능한 연도의 범위를 벗어남"
            case .isEmptyMonth:
                message = "월의 입력값이 비었음"
            case .notIntMonth:
                message = "입력한 월을 정수로 변환할 수 없음"
            case .outOfMonth:
                message = "입력 가능한 월의 범위를 벗어남"
            case .isEmptyDate:
                message = "일의 입력값이 비었음"
            case .notIntDate:
                message = "입력한 일을 정수로 변환할 수 없음"
            case .outOfDate:
                message = "입력 가능한 일의 범위를 벗어남"
            }
        }
        output.value = message
    }
    
    // MARK: - 날짜 유효성 검사
    
    @discardableResult
    private func isValidDate() throws(DateError) -> Bool {
        
        let year = self.year.value
        let month = self.month.value
        let date = self.date.value
        
        // 연도 유효성 검사
        if year.isEmpty {
            throw .isEmptyYear
        }
        
        if Int(year) == nil {
            throw .notIntYear
        }
        
        if Int(year)! < 0 {
            throw .outOfYear
        }
        
        // 월 유효성 검사
        if month.isEmpty {
            throw .isEmptyMonth
        }
        
        if Int(month) == nil {
            throw .notIntMonth
        }
        
        // 범위 비교는 한개와 비교하기 때문에 시간복잡도가 O(1)이지만, contains는 배열의 모두와 비고하기 떄문에 시간복잡도가 O(1)보다 큼.
        // 코드 시간복잡도 개선
        if Int(month)! < 1 || Int(month)! > 12 {
            throw .outOfMonth
        }
//        if !(1...12).contains(Int(month)!) {
//            throw .outOfMonth
//        }
        
        // 일 유효성 검사
        if date.isEmpty {
            throw .isEmptyDate
        }
        
        if Int(date) == nil {
            throw .notIntDate
        }
        
        // 한달 일수에 따른 유효성 검사
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
