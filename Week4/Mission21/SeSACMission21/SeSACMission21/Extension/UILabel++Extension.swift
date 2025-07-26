//
//  UILabel++Extension.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import UIKit

extension UILabel {
    
    func setLabelUI(_ text: String, size: CGFloat, weight: UIFont.Weight, color: UIColor) {
        self.textColor = color
        self.font = .systemFont(ofSize: size, weight: weight)
        self.text = text
    }
}
