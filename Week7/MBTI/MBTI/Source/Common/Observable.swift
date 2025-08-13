//
//  Observable.swift
//  MBTI
//
//  Created by HyoTaek on 8/13/25.
//

import Foundation

final class Observable<T> {
    
    // MARK: - Action
    
    var action: ((T) -> Void)?
    
    // MARK: - Value
    
    var value: T {
        didSet {
            action?(value)
        }
    }
    
    // MARK: - Init
    
    init(_ value: T) {
        self.value = value
    }
    
    // MARK: - Bind
    
    func bind(action: @escaping (T) -> Void) {
        action(value)
        self.action = action
    }
    
    // MARK: - Lazy Bind
    
    func lazyBind(action: @escaping (T) -> Void) {
        self.action = action
    }
}
