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
        resultTextView.isScrollEnabled = true
        resultTextView.textColor = .gray
    }
    
    func setTextView(with text: String) {
        var wholeText = ""
        guard let endNumber = Int(text) else {
            print("<< 정수 변환 실패")
            return
        }
        
        for i in 1...endNumber {
            let convertedToString = String(i)
            var result = ""
            
            convertedToString.forEach {
                if $0 == "3" || $0 == "6" || $0 == "9" {
                    result += "👏"
                } else {
                    result += "\($0)"
                }
            }
            
            if i != endNumber {
                wholeText += "\(result), "
            } else {
                wholeText += "\(result)"
            }
        }
        resultTextView.text = wholeText
    }
    
    // MARK: - Action
    
    @IBAction func didEndEditing(_ sender: UITextField) {
        if let textNumber = numberInputTextField.text {
            setTextView(with: textNumber)
        } else {
            print("<< 텍스트필드 옵셔널 바인딩 실패")
        }
    }
}
