//
//  SubViewController.swift
//  SesacHomeWork2
//
//  Created by HyoTaek on 7/2/25.
//

import UIKit

class SubViewController: UIViewController {
    
    // MARK: - Components
    
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var textField1: UITextField!
    @IBOutlet var textField2: UITextField!
    @IBOutlet var textField3: UITextField!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<labelCollection.count {
            
        }
        labelCollection[0].textColor = .red
        labelCollection[1].textColor = .green
        labelCollection[2].textColor = .blue
        
        setTextFieldUI(textField1)
        setTextFieldUI(textField2, isSerity: true)
        setTextFieldUI(textField3)
    }
    
    // MARK: - UITextField Action
    
    // Exit Action
    @IBAction func didExitTextField(_ sender: UITextField) {
    }
    
    // MARK: - UIButton Action
    
    @IBAction func didTapConfirmButton(_ sender: UIButton) {
        print(#function)
        
        // 키보드 내리기
        view.endEditing(false)
    }
    
    // 함수 호출 연산자는 ()이다.
    // textField는 내부 매개변수: Parameter Name
    // tf는 외부 매개변수: Argument Label
    // _: wildCard 식별자
    
    // Parameter(매개변수): 함수를 아무리 많이 호출해도 달라지지 않는 주머니
    // Argument(인자): 함수를 호출할 때 주머니에 넣는 값
    func setTextFieldUI(_ textField: UITextField, isSerity: Bool = false) {
        textField.text = "hello"
        textField.textColor = .red
        textField.isSecureTextEntry = isSerity
    }
}
