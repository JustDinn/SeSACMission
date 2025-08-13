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

    // MARK: - Property
    
    private let profileSettingViewModel = ProfileSettingViewModel()
    
    // MARK: - Component
    
    private let profileImageBackgroundView = UIView().then {
        $0.backgroundColor = .main
        $0.layer.cornerRadius = 65
        $0.layer.masksToBounds = true
    }
    
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 60
        $0.layer.masksToBounds = true
        $0.backgroundColor = .white
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setConstraints()
        bind()
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            profileImageBackgroundView
        ].forEach(view.addSubview)
        
        [
            profileImageView
        ].forEach(profileImageBackgroundView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        profileImageBackgroundView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(130)
        }
        
        profileImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(120)
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        profileSettingViewModel.output.randomImage.bind { [weak self] randomImage in
            guard let self = self else { return }
            
            profileImageView.image = UIImage(named: randomImage)
        }
    }
}
