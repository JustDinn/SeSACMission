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
    
    private let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력해주세요 :)"
    }
    
    private let borderLine = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let validResultLabel = UILabel().then {
        $0.text = "사용할 수 있는 닉네임이에요"
        $0.textColor = .red
    }
    
    private let mbtiTitleLabel = UILabel().then {
        $0.text = "MBTI"
        $0.font = .systemFont(ofSize: 20, weight: .black)
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
            profileImageBackgroundView,
            nicknameTextField,
            borderLine,
            validResultLabel,
            mbtiTitleLabel
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
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(profileImageBackgroundView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        borderLine.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.height.equalTo(1)
        }
        
        validResultLabel.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom).offset(16)
            $0.leading.equalTo(nicknameTextField)
        }
        
        mbtiTitleLabel.snp.makeConstraints {
            $0.top.equalTo(validResultLabel.snp.bottom).offset(40)
            $0.leading.equalTo(borderLine)
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
