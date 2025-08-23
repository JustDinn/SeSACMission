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
        $0.backgroundColor = .main
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setConstraints()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settingViewModel.updateNickname()
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        view.backgroundColor = .main
        setBackNaviBar("설정")
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
        let input = SettingViewModel.Input(selectedCell: settingTableView.rx.itemSelected)
        let output = settingViewModel.transform(input: input)
        
        output.cellTitle
            .bind(to: settingTableView.rx.items(cellIdentifier: SettingTableViewCell.reuseIdentifier, cellType: SettingTableViewCell.self)) { row, data, cell in
                cell.configureCell(with: data)
            }
            .disposed(by: disposeBag)
        
        output.pushedVC
            .bind(with: self) { owner, _ in
                let editNicknameVC = EditNicknameViewController()
                owner.navigationController?.pushViewController(editNicknameVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
