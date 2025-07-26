//
//  UITextField++Extension.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import UIKit

extension UITextField {
    func setPlaceholderUI(color: UIColor) {
        guard let placeholder = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: color])
    }
}
