//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/8/25.
//

import Foundation

final class CurrencyViewModel {
    
    // MARK: - Property
    
    var resultMessage = ""
    
    // MARK: - Observable
    
    var input = Observable("")
    var output = Observable("")
    
    // MARK: - Init
    
    init() {
        input.bind { text in
            do {
                try self.isValid(money: text)
                self.wonToDollar(money: text)
            } catch let error as CurrencyErrorEnum{
                switch error {
                case .isEmpty:
                    self.resultMessage = "아무것도 입력하지 않았습니다"
                case .isNotInt:
                    self.resultMessage = "정수만 입력 가능합니다"
                case .isNegativeInt:
                    self.resultMessage = "음수를 입력했습니다"
                }
            } catch {
                self.resultMessage = "알 수 없는 에러가 발생했습니다"
            }
            self.output.value = self.resultMessage
        }
    }
    
    // MARK: - Method
    
    // 입력 텍스트 유효성 검사
    @discardableResult
    private func isValid(money: String) throws(CurrencyErrorEnum) -> Bool {
        
        // 입력 텍스트가 빈 값
        if money.isEmpty {
            throw .isEmpty
        }
        
        // 입력 텍스트가 정수가 아님
        if Int(money) == nil {
            throw .isNotInt
        }
        
        // 입력 텍스트가 음수
        if Int(money)! < 0 {
            throw .isNegativeInt
        }
        
        return true
    }
    
    // 원화 -> 달러 변환
    private func wonToDollar(money: String) {
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = Double(money)! / exchangeRate
        
        resultMessage = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
