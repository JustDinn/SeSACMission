//
//  UIViewController++Extension.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import UIKit
import Then

extension UIViewController {
    
    // MARK: - Navi Bar
    
    // Back 버튼이 없는 Navigation Bar
    func setNaviBar(_ title: String) {
        let titleLabel = UILabel().then {   
            $0.setLabelUI(title, size: 18, weight: .black, color: .white)
        }
        
        self.navigationItem.titleView = titleLabel
    }
}
