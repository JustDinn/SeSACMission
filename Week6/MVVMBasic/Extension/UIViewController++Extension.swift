//
//  UIViewController++Extension.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/8/25.
//

import UIKit

extension UIViewController {
    
    // MARK: - Alert
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
         
        let okButton = UIAlertAction(title: "확인", style: .default) { _ in }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel) { _ in }
        
        [
            okButton,
            cancelButton
        ].forEach(alertController.addAction)
        
        present(alertController, animated: true)
    }
}
