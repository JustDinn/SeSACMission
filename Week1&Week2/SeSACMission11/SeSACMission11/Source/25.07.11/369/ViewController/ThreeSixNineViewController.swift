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
    @IBOutlet var resultTextView: UITextView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextField()
        setTextView()
    }
    
    // MARK: - Set TextField
    
    func setTextField() {
        numberInputTextField.placeholder = "최대 숫자를 입력해주세요"
        numberInputTextField.layer.borderColor = UIColor.gray.cgColor
        numberInputTextField.layer.borderWidth = 1
        numberInputTextField.textAlignment = .center
    }
    
    // MARK: - Set TextView
    
    func setTextView() {
        resultTextView.isEditable = false
    }
    
    func setTextView(with number: Int) {
        var wholeText = ""
        
        for i in 1...number {
            if i != number {
                wholeText += "\(i), "
            } else {
                wholeText += "\(i)"
            }
        }
        resultTextView.text = wholeText
    }
    
    // MARK: - Action
    
    @IBAction func didEndEditing(_ sender: UITextField) {
        if let textNumber = numberInputTextField.text {
            if let intNumber = Int(textNumber) {
                setTextView(with: intNumber)
            } else {
                print("<< 정수 변환 실패")
            }
        } else {
            print("<< 텍스트필드 옵셔널 바인딩 실패")
        }
    }
}
