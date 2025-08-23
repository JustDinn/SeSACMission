//
//  UIViewController++Extetnsion.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/23/25.
//

import UIKit

extension UIViewController {
    
    // title만 있는 Navigation Bar
    func setTitleNaviBar(_ title: String) {
        let titleLabel = UILabel().then {
            $0.setLabel(text: title, fontSize: 18, fontWeight: .black, textColor: .tint)
        }
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
    
    // Back 버튼이 있는 Navigation Bar
    func setBackNaviBar(_ title: String) {
        let titleLabel = UILabel().then {
            $0.setLabel(text: title, fontSize: 18, fontWeight: .black, textColor: .tint)
        }
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        self.navigationController?.navigationBar.tintColor = .tint
    }
    
    // MARK: - Action
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
