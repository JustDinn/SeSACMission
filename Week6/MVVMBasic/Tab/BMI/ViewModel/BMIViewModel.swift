//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/11/25.
//

import Foundation

final class BMIViewModel {
    
    // MARK: - Property
    
    var height: String? = "" {
        didSet {
            updateMessage()
        }
    }
    var weight: String? = "" {
        didSet {
            updateMessage()
        }
    }
    var result: ((String, String) -> Void)?
    
    private var bmi: String {
        let height = (Double(height!) ?? 0) / 100
        let weight = Double(weight!) ?? 0
        
        return String(format: "%.2f", weight / (height * height))
    }
    private var title = ""
    private var message = ""
    
    // MARK: - 메시지 업데이트
    
    private func updateMessage() {
        do {
            try isValidBMI()
            title = "BMI"
            message = "\(bmi)"
        } catch {
            switch error {
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
            title = "경고"
        }
        result?(title, message)
    }
    
    //MARK: - BMI 유효성 검사
    
    @discardableResult
    private func isValidBMI() throws(BMIValidError) -> Bool {
        
        // 키, 몸무게 옵셔널 바인딩 실패
        guard let height,
              let weight else {
            throw .unknownError
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
