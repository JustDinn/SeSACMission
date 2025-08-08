//
//  WordCounterViewModel.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/8/25.
//

import Foundation

final class WordCounterViewModel {
    
    // MARK: - Property
    
    var text: String? = "" {
        didSet {
            updateCharacterCount()
        }
    }
    
    var result: ((String) -> Void)?
    
    // MARK: - Update CharacterCount
    
    private func updateCharacterCount() {
        guard let text else {
            result?("입력한 글자에 문제가 생겼습니다")
            return
        }
        
        let count = text.count
        result?("현재까지 \(count)글자 작성중")
    }
}
