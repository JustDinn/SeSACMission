//
//  SimpleTableViewViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/19/25.
//

import UIKit
import SnapKit
import Then

final class SimpleTableViewViewController: UIViewController {
    
    // MARK: - Component
    
    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .systemOrange
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
            tableView
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
