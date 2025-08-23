//
//  UILabel++Extension.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/23/25.
//

import UIKit

extension UILabel {
    
    // Label UI 설정
    func setLabel(
        text: String,
        fontSize: CGFloat,
        fontWeight: UIFont.Weight,
        textColor: UIColor = .black
    ) {
        self.text = text
        self.textColor = textColor
        self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
    }
}
