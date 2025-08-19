//
//  RootTableViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/20/25.
//

import UIKit
import SnapKit
import Then

final class RootTableViewController: UIViewController {

    // MARK: - Component
    
    private let tableView = UITableView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        view.addSubview(tableView)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
