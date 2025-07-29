//
//  UIViewController++Extension.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import UIKit
import Then

extension UIViewController {
    
    // MARK: - Navi Bar
    
    // Back 버튼이 없는 Navigation Bar
    func setNaviBar(_ title: String) {
        let titleLabel = UILabel().then {
            $0.setLabelUI(title, size: 18, weight: .black, color: .white)
        }
        
        self.navigationItem.titleView = titleLabel
    }
    
    // Back 버튼이 있는 Navigation Bar
    func setBackNaviBar(_ title: String) {
        let titleLabel = UILabel().then {
            $0.setLabelUI(title, size: 18, weight: .black, color: .white)
        }
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .white
    }
    
    // MARK: - Push ViewController
    
    // SearchResultVC로 push
    func pushSearchResultVC(keyword: String) {
        let searchResultVC = SearchResultViewController(keyword: keyword)
        
        searchResultVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
    
    // MARK: - Alert
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "재시도", style: .default) { ok in
            print("<< 재시도 선택", ok)
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel) { cancel in
            print("<< 취소 선택", cancel)
        }
        
        [
            okButton,
            cancelButton
        ].forEach(alertController.addAction)
        
        present(alertController, animated: true)
    }
}
