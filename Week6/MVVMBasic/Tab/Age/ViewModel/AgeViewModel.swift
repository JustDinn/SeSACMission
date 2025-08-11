//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/9/25.
//

import Foundation

final class AgeViewModel {
    
    // MARK: - Observable
    
    var age = Observable("")
    var output = Observable("")
    
    // MARK: - Init
    
    init() {
        age.bind { age in
            var message = ""
            
            do {
                try self.isValidAge(age: age)
                message = "나이 유효성 검사 통과: \(age)"
            } catch let error as AgeValidError {
                switch error {
                case .empty:
                    message = "나이 입력 비었음"
                case .notInt:
                    message = "나이 정수 변환 실패"
                case .outOfRange:
                    message = "인간의 나이를 벗어난 당신은 외계인👽"
                }
            } catch {
                message = "예상치 못한 에러가 발생했습니다"
            }
            self.output.value = message
        }
    }
    
    // MARK: - 나이 유효성 검사
    
    @discardableResult
    private func isValidAge(age: String) throws(AgeValidError) -> Bool {
        
        // age가 빈 값일 경우
        if age.isEmpty {
            throw .empty
        }
        
        // age가 정수 변환 불가능일 경우
        if Int(age) == nil {
            throw .notInt
        }
        
        // age의 범위가 벗어난 경우
        // 위에서 Int(age)를 통과했으므로 강제 언래핑
        if Int(age)! < 1 || Int(age)! > 100 {
            throw .outOfRange
        }
        
        return true
    }
}
