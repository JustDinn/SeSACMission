//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/11/25.
//

import Foundation

final class BMIViewModel {
    
    // MARK: - Property
    
    private var bmi: String {
        let height = (Double(height.value) ?? 0) / 100
        let weight = Double(weight.value) ?? 0
        
        return String(format: "%.2f", weight / (height * height))
    }
    private var message = ""
    
    // MARK: - Observable
    
    var weight = Observable("")
    var height = Observable("")
    var bmiResult = Observable("")
    
    // MARK: - Init
    
    init() {
        weight.bind { _ in
            self.updateMessage()
        }
        
        height.bind { _ in
            self.updateMessage()
        }
    }
    
    // MARK: - 메시지 업데이트
    
    private func updateMessage() {
        do {
            try isValidBMI()
            message = "\(bmi)"
        } catch {
            switch error {
            case .isHeightEmpty:
                message = "키에 아무것도 입력하지 않았습니다"
            case .isWeightEmpty:
                message = "체중에 아무것도 입력하지 않았습니다"
            case .isNotIntHeight:
                message = "키에는 정수를 입력해야합니다"
            case .outOfHeight:
                message = "입력한 키가 정말 맞습니까?"
            case .isNotIntWeight:
                message = "체중에는 정수를 입력해야합니다"
            case .outOfWeight:
                message = "입력한 체중이 정말 맞습니까?"
            case .unknownError:
                message = "알 수 없는 에러가 발생했습니다"
            }
        }
        bmiResult.value = message
    }
    
    //MARK: - BMI 유효성 검사
    
    @discardableResult
    private func isValidBMI() throws(BMIValidError) -> Bool {
        
        let height = height.value
        let weight = weight.value
        
        // 키가 빈 값일 경우
        if height.isEmpty {
            throw .isHeightEmpty
        }
        
        // 몸무게가 빈 값일 경우
        if weight.isEmpty {
            throw .isWeightEmpty
        }
        
        // 키 정수 변환 실패
        if Int(height) == nil {
            throw .isNotIntHeight
        }
        
        // 키 정상 범위 벗어남
        if !(100...200).contains(Int(height)!) {
            throw .outOfHeight
        }
        
        // 몸무게 정수 변환 실패
        if Int(weight) == nil {
            throw .isNotIntWeight
        }
        
        // 몸무게 정상 범위 벗어남
        if !(20...200).contains(Int(weight)!) {
            throw .outOfWeight
        }
        
        // 모든 조건 통과 시 유효성 검사 통과
        return true
    }
}
