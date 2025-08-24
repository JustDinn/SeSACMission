//
//  UIViewController++Extetnsion.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/23/25.
//

import UIKit

extension UIViewController {
    
    // title만 있는 Navigation Bar
    func setTitleNaviBar(_ title: String) {
        let titleLabel = UILabel().then {
            $0.setLabel(text: title, fontSize: 18, fontWeight: .black, textColor: .tint)
        }
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
    
    // Back 버튼이 있는 Navigation Bar
    func setBackNaviBar(_ title: String) {
        let titleLabel = UILabel().then {
            $0.setLabel(text: title, fontSize: 18, fontWeight: .black, textColor: .tint)
        }
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        self.navigationController?.navigationBar.tintColor = .tint
    }
    
    // 프로필 버튼 Navigation Bar
    func setProfileNaviBar(_ title: String) {
        let titleLabel = UILabel().then {
            $0.setLabel(text: title, fontSize: 18, fontWeight: .black, textColor: .tint)
        }
        
        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(profileButtonTapped)
        )
        profileButton.tintColor = .tint
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: nil,
            style: .plain,
            target: nil,
            action: nil
        )
        self.navigationItem.rightBarButtonItem = profileButton
    }
    
    // MARK: - Action
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func profileButtonTapped() {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    // MARK: - Alert
    
    func showAlert(title: String, message: String, okCompletion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
         
        let okButton = UIAlertAction(title: "확인", style: .default) { _ in
            okCompletion?()
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        
        [
            okButton,
            cancelButton
        ].forEach(alertController.addAction)
        
        present(alertController, animated: true)
    }
}
