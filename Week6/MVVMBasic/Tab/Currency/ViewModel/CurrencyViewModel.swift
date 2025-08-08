//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/8/25.
//

import Foundation

final class CurrencyViewModel {
    
    // MARK: - Property
    
    var moneyRawString: String? = "" {
        didSet {
            wonToDollar()
        }
    }
    var resultMessage = ""
    
    // MARK: - Method
    
    private func wonToDollar() {
        guard let moneyRawString,
              let money = Double(moneyRawString) else {
            resultMessage = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = money / exchangeRate
        
        resultMessage = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
