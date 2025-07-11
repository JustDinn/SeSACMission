//
//  UIViewController++Extensions.swift
//  SesacWeek1Homework
//
//  Created by HyoTaek on 7/8/25.
//

import UIKit

extension UIViewController {
    
    func makeAlertController(alertVC: UIAlertController, title: String, message: String, okHandler: ((UIAlertAction) -> Void)? = nil, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: okHandler)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: cancelHandler)
        
        alertController.addAction(cancel)
        alertController.addAction(ok)
        
        present(alertController, animated: true)
    }
    
}
