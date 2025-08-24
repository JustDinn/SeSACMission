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
    
    private let containerView = UIView().then {
        $0.backgroundColor = .tint
        $0.layer.cornerRadius = 75
        $0.layer.masksToBounds = true
    }
    
    private let tamagotchiImageView = UIImageView().then {
        $0.layer.cornerRadius = 72
        $0.layer.masksToBounds = true
    }
    
//    private let tamagotchiNameLabel = UILabel().then {
//        $0.font = .systemFont(ofSize: 13, weight: .semibold)
//        $0.textColor = .tint
//        $0.backgroundColor = .skyBlue
//        $0.layer.cornerRadius = 3
//        $0.layer.masksToBounds = true
//        $0.layer.borderColor = UIColor.tint.cgColor
//        $0.layer.borderWidth = 1
//    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        setProfileNaviBar("대장님의 다마고치")
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            containerView
        ].forEach(view.addSubview)
        
        [
            tamagotchiImageView
        ].forEach(containerView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(150)
        }
        
        tamagotchiImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(144)
        }
        
//        tamagotchiNameLabel.snp.makeConstraints {
//            $0.top.equalTo(containerView.snp.bottom).offset(8)
//            $0.centerX.equalTo(containerView)
//        }
    }
}
