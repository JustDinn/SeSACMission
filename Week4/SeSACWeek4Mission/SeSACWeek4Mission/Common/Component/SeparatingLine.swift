//
//  SeparatingLine.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/24/25.
//

import UIKit

final class SeparatingLine: UIView {
    
    // MARK: - Init
    
    init(color: UIColor) {
        super.init(frame: .zero)
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
