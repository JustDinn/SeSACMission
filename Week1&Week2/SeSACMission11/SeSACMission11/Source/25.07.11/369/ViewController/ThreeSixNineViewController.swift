//
//  ThreeSixNineViewController.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/13/25.
//

import UIKit

class ThreeSixNineViewController: UIViewController {

    // MARK: - Components
    
    @IBOutlet var numberInputTextField: UITextField!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextField()
    }
    
    // MARK: - Set TextField
    
    func setTextField() {
        numberInputTextField.placeholder = "최대 숫자를 입력해주세요"
        numberInputTextField.layer.borderColor = UIColor.gray.cgColor
        numberInputTextField.layer.borderWidth = 1
        numberInputTextField.textAlignment = .center
    }
}
