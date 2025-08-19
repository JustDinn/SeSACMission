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
        $0.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self
        
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

// MARK: - UITableView DataSource, Delegate

extension SimpleTableViewViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 섹션당 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    // 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.identifier, for: indexPath) as! SimpleTableViewCell
        
        return cell
    }
    
    // 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
