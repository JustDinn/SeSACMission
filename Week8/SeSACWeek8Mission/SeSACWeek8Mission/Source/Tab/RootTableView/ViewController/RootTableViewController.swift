//
//  RootTableViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/20/25.
//

import UIKit
import SnapKit
import Then

import RxSwift
import RxCocoa

final class RootTableViewController: UIViewController {

    // MARK: - DisposeBag
    
    var disposeBag = DisposeBag()
    
    // MARK: - Component
    
    private let tableView = UITableView().then {
        $0.register(RootTableTableViewCell.self, forCellReuseIdentifier: RootTableTableViewCell.identifier)
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
        view.addSubview(tableView)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Observable
    
    let items = Observable.just(["SimpleTableView"])
    
    // MARK: - Bind
    
    private func bind() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: RootTableTableViewCell.identifier, cellType: RootTableTableViewCell.self)) { (row, element, cell) in
                cell.label.text = "\(element)"
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .bind(with: self, onNext: { owner, tableView in
                if tableView == "SimpleTableView" {
                    let vc = SimpleTableViewViewController()
                    owner.navigationController?.pushViewController(vc, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
