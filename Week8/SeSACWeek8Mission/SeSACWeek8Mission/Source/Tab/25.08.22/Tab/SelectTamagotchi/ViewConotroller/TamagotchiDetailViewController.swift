//
//  TamagotchiDetailViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/25/25.
//

import UIKit
import SnapKit
import Then

final class TamagotchiDetailViewController: UIViewController {

    // MARK: - Component
    
    private let tamagotchiInfoView = UIView().then {
        $0.backgroundColor = .main
        $0.layer.cornerRadius = 10
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            tamagotchiInfoView
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        tamagotchiInfoView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(400)
        }
    }
}
