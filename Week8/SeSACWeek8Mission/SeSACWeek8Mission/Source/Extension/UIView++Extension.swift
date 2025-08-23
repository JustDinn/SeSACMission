//
//  UIView++Extension.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/24/25.
//

import UIKit
import Toast

enum ToastPosition {
    case top
    case center
    case bottom
    case custom(y: CGFloat)
    
    func point(in view: UIView) -> CGPoint {
        let centerX = view.frame.width / 2
        
        switch self {
        case .top:
            return CGPoint(x: centerX, y: view.frame.height * 0.25)
        case .center:
            return CGPoint(x: centerX, y: view.frame.height * 0.5)
        case .bottom:
            return CGPoint(x: centerX, y: view.frame.height * 0.75)
        case .custom(let y):
            return CGPoint(x: centerX, y: y)
        }
    }
}

extension UIView {
    
    // border 설정
    func setBorder(color: CGColor = UIColor.systemRed.cgColor, width: CGFloat = 1) {
        self.layer.borderColor = color
        self.layer.borderWidth = width
    }
    
    // 토스트 메세지 생성
    func showToast(_ message: String, position: ToastPosition = .top, duration: TimeInterval = 1.5) {
        self.makeToast(
            message,
            duration: duration,
            point: position.point(in: self),
            title: nil,
            image: nil
        ) { _ in }
    }
}
