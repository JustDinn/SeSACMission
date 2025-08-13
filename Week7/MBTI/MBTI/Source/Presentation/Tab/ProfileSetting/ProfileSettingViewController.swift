//
//  ProfileSettingViewController.swift
//  MBTI
//
//  Created by HyoTaek on 8/13/25.
//

import UIKit
import SnapKit
import Then

final class ProfileSettingViewController: UIViewController {

    // MARK: - Component
    
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 65
        $0.layer.masksToBounds = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            profileImageView
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(130)
        }
    }
}
