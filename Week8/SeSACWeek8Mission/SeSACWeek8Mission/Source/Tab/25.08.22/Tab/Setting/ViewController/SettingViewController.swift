//
//  SettingViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/22/25.
//

import UIKit
import SnapKit
import Then

final class SettingViewController: UIViewController {
    
    // MARK: - Component
    
    private lazy var settingTableView = UITableView().then {
        $0.backgroundColor = .systemBlue
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
            settingTableView
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        settingTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
