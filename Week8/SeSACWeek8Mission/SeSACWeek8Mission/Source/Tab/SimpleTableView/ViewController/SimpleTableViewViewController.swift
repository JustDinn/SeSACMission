//
//  SimpleTableViewViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/19/25.
//

import UIKit
import SnapKit
import Then

import RxSwift
import RxCocoa

final class SimpleTableViewViewController: UIViewController {
    
    // MARK: - DisposeBag
    
    var disposeBag = DisposeBag()
    
    // MARK: - Component
    
    private lazy var tableView = UITableView().then {
        $0.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.identifier)
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
            tableView
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Observable
    
    let items = Observable.just((0..<20).map { "\($0) "})
    
    // MARK: - Bind
    
    private func bind() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: SimpleTableViewCell.identifier, cellType: SimpleTableViewCell.self)) { (row, element, cell) in
                cell.label.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                self.showAlert(title: "알림", message: "Tapped \(value)")
            })
            .disposed(by: disposeBag)

//        tableView.rx
//            .itemAccessoryButtonTapped
//            .subscribe(onNext: { indexPath in
//                self.showAlert(title: "알림", message: "Tapped Detail \(indexPath)")
//            })
//            .disposed(by: disposeBag)
    }
    
    // MARK: - Alert
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default)
        
        alertController.addAction(okButton)
        present(alertController, animated: true)
    }
}
