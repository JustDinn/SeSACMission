//
//  UIView++Extension.swift
//  SeSACMission21
//
//  Created by HyoTaek on 8/12/25.
//

import UIKit
//import Toast_Swift
import Toast

extension UIView {
    
    // MARK: - Toast Position
    
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
    
    // MARK: - Convenience Methods
    
    func showToast(_ message: String, position: ToastPosition = .top, duration: TimeInterval = 1.5) {
        self.makeToast(
            message,
            duration: duration,
            point: position.point(in: self),
            title: nil,
            image: nil
        ) { _ in }
    }
    
    func showToast(_ message: String, position: ToastPosition = .top, duration: TimeInterval = 1.5, completion: @escaping () -> Void) {
        self.makeToast(
            message,
            duration: duration,
            point: position.point(in: self),
            title: nil,
            image: nil
        ) { _ in
            completion()
        }
    }
}
