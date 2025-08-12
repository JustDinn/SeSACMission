//
//  Observable.swift
//  SeSACMission21
//
//  Created by HyoTaek on 8/12/25.
//

import Foundation

final class Observable<T> {
    
    // MARK: - Action
    
    var action: ((T) -> Void)?
    
    // MARK: - Property
    
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
    
    func bind(closure: @escaping (T) -> Void) {
        closure(value)
        self.action = closure
    }
}
