//
//  SettingViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/22/25.
//

import UIKit
import SnapKit
import Then

import RxSwift
import RxCocoa

final class SettingViewController: UIViewController {
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - ViewModel
    
    private let settingViewModel = SettingViewModel()
    
    // MARK: - Component
    
    private lazy var settingTableView = UITableView().then {
        $0.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reuseIdentifier)
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
            settingTableView
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        settingTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        let output = settingViewModel.transform()
        
        output.cellTitle
            .bind(to: settingTableView.rx.items(cellIdentifier: SettingTableViewCell.reuseIdentifier, cellType: SettingTableViewCell.self)) { row, data, cell in
                cell.configureCell(with: data)
            }
            .disposed(by: disposeBag)
    }
}
