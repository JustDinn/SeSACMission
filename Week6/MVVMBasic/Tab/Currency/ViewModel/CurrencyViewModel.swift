//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/8/25.
//

import Foundation

final class CurrencyViewModel {
    
    // MARK: - Property
    
    var money: String? = "" {
        didSet {
            do {
                try isValid()
                wonToDollar()
            } catch {
                switch error {
                case .unknownError:
                    resultMessage = "알 수 없는 에러가 발생했습니다"
                }
            }
        }
    }
    var resultMessage = ""
    var result: ((String) -> Void)?
    
    // MARK: - Method
    
    // 입력 텍스트 유효성 검사
    @discardableResult
    private func isValid() throws(CurrencyErrorEnum) -> Bool {
        
        // 옵셔널 바인딩 실패
        guard let money else {
            throw .unknownError
        }
        
//        // 입력 텍스트가 빈 값
//        if money.isEmpty {
//            throw .isEmpty
//        }
        
        return true
    }
    
    // 원화 -> 달러 변환
    private func wonToDollar() {
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = Double(money!)! / exchangeRate
        
        resultMessage = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
        result?(resultMessage)
    }
}
