//
//  ReuseIdentifier.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/22/25.
//

import Foundation

protocol ReuseIdentifier {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifier {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
