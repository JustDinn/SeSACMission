//
//  WordCounterViewModel.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/8/25.
//

import Foundation

final class WordCounterViewModel {
    
    // MARK: - Property
    
    var input = Observable("")
    var output = Observable("")
    
    // MARK: - Init
    
    init() {
        input.bind { text in
            let count = text.count
            self.output.value = "현재까지 \(count)글자 작성중"
        }
    }
}
