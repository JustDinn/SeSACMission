//
//  MainViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/25/25.
//

import UIKit
import SnapKit
import Then

final class MainViewController: UIViewController {

    // MARK: - Component
    
    private let bubbleImageView = UIImageView().then {
        $0.image = UIImage(named: "bubble")
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .tint
        $0.layer.cornerRadius = 75
        $0.layer.masksToBounds = true
    }
    
    private let tamagotchiImageView = UIImageView().then {
        $0.layer.cornerRadius = 72
        $0.layer.masksToBounds = true
    }
    
    private let tamagotchiNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .tint
        $0.backgroundColor = .skyBlue
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.tint.cgColor
        $0.layer.borderWidth = 1
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureVC()
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            bubbleImageView,
            containerView,
            tamagotchiNameLabel
        ].forEach(view.addSubview)
        
        [
            tamagotchiImageView
        ].forEach(containerView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        bubbleImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(containerView.snp.top).offset(-16)
        }
        
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(150)
        }
        
        tamagotchiImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(144)
        }
        
        tamagotchiNameLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(16)
            $0.centerX.equalTo(containerView)
        }
    }
    
    // MARK: - Configure VC
    
    private func configureVC() {
        let nickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.value) ?? "대장"
        guard let tamagotchiName = UserDefaults.standard.string(forKey: UserDefaultsKey.tamagotchiName.value) else {
            return
        }
        guard let tamagotchiImage = UserDefaults.standard.string(forKey: UserDefaultsKey.tamagotchiImage.value) else {
            return
        }
        
        setProfileNaviBar("\(nickname)님의 다마고치")
        tamagotchiImageView.image = UIImage(named: tamagotchiImage)
        tamagotchiNameLabel.text = tamagotchiName
    }
}
