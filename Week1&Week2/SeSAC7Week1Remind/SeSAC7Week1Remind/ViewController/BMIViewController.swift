//
//  BMIViewController.swift
//  SeSAC7Week1Remind
//
//  Created by HyoTaek on 7/4/25.
//

import UIKit

enum borderColor {
    case normal
    case focused
}

final class BMIViewController: UIViewController {

    // MARK: - Components
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var bmiImageView: UIImageView!
    
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var randomCalculateBMIButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    let alertController = UIAlertController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeLabelUI(label: titleLabel, title: "BMI Calculator")
        makeLabelUI(label: subTitleLabel, title: """
                                                 당신의 BMI 지수를
                                                 알려드릴게요
                                                 """)
        makeImageViewUI()
        makeLabelUI(label: heightLabel, title: "키가 어떻게 되시나요?")
        makeTextFieldUI(textField: heightTextField, color: .focused, borderWidth: 1.5)
        makeLabelUI(label: weightLabel, title: "몸무게는 어떻게 되시나요?")
        makeTextFieldUI(textField: weightTextField, color: .focused, borderWidth: 1.5)
        makeButtonUI(button: randomCalculateBMIButton, title: "랜덤 BMI 계산", backgroundColor: .clear, textColor: .systemRed, fontSize: 13)
        makeButtonUI(button: resultButton, title: "결과 확인", backgroundColor: .purple, textColor: .white, fontSize: 20)
        makeLabelUI(label: resultLabel, title: "")
    }
    
    // MARK: - Setting
    
    // Make Label UI
    private func makeLabelUI(label: UILabel, title: String) {
        label.text = title
        label.numberOfLines = 0
    }
    
    // Make ImageView UI
    private func makeImageViewUI() {
        bmiImageView.image = UIImage(named: "bmiImage")
    }
    
    // Make TextField UI
    private func makeTextFieldUI(textField: UITextField, color: borderColor, borderWidth: CGFloat) {
        setBorder(textField: textField, color: color, borderWidth: borderWidth)
    }
    
    // Make Button UI
    private func makeButtonUI(button: UIButton, title: String, backgroundColor: UIColor, textColor: UIColor, fontSize: CGFloat) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
    }
    
    // Make AlertVC
    private func makeAlertController(alertVC: UIAlertController, title: String, message: String, okHandler: ((UIAlertAction) -> Void)? = nil, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // TODO: ok를 눌렀을 때 클로저 실행..?
        // TODO: cancel을 눌렀을 때 클로저 실행..?
        let ok = UIAlertAction(title: "확인", style: .default, handler: okHandler)
        let cancel = UIAlertAction(title: "취소", style: .destructive, handler: cancelHandler)
        
        alertController.addAction(cancel)
        alertController.addAction(ok)
        
        present(alertController, animated: true)
    }
    
    // MARK: - Action
    
    @IBAction func didTapRandomBMICalculate(_ sender: UIButton) {
        let height = Double.random(in: 1..<2)
        let weight = Double.random(in: 30..<130)
        let bmi = calculateBMI(height: height, weight: weight)
        
        let heightToString = String(format: "%.2f", height)
        let weightToString = String(format: "%.2f", weight)
        let bmiToString = String(format: "%.2f", bmi)
        
        heightTextField.text = heightToString
        weightTextField.text = weightToString
        resultLabel.text = bmiToString
    }
    
    @IBAction func didTapCalculateBMIButton(_ sender: UIButton) {
        guard let height = heightTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !height.isEmpty else {
            makeAlertController(alertVC: alertController, title: "경고", message: "키를 입력해주세요.")
            
            return
        }
        guard var heightToDouble = Double(height) else {
            makeAlertController(alertVC: alertController, title: "경고", message: "유효한 키를 입력해주세요. (예: 1.7)")
            return
        }
        guard let weight = weightTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !weight.isEmpty else {
            makeAlertController(alertVC: alertController, title: "경고", message: "몸무게를 입력해주세요.")
            return
        }
        guard let weightToDouble = Double(weight) else {
            makeAlertController(alertVC: alertController, title: "경고", message: "유효한 몸무게를 입력해주세요. (예: 60)")
            return
        }
        
        if heightToDouble > 100 && heightToDouble < 200 {
            if weightToDouble < 30 || weightToDouble > 150 {
                makeAlertController(alertVC: alertController, title: "안내", message: "입력한 몸무게가 맞으신지 확인해주세요. (예: 60kg -> 60)")
                resultLabel.text = ""
                return
            } else {
                makeAlertController(alertVC: alertController, title: "안내", message: "키 입력을 cm 단위로 하셔서 자동으로 변환해드렸습니다 :D")
                heightToDouble = heightToDouble / 100.0
                heightTextField.text = "\(heightToDouble)"
            }
        } else {
            makeAlertController(alertVC: alertController, title: "안내", message: "입력한 키가 맞으신지 확인해주세요. (예: 170cm -> 1.7)")
            resultLabel.text = ""
            return
        }
        
        let bmi = calculateBMI(height: heightToDouble, weight: weightToDouble)
        let bmiToString = String(format: "%.2f", bmi)
        
        resultLabel.text = bmiToString
    }
}

// MARK: - Other Functions

extension BMIViewController {
    // Set TextField border
    private func setBorder(textField: UITextField, color: borderColor, borderWidth: CGFloat) {
        switch color {
        case .normal:
            textField.layer.borderColor = UIColor.gray.cgColor
        case .focused:
            textField.layer.borderColor = UIColor.black.cgColor
        }
        textField.layer.borderWidth = borderWidth
        textField.layer.cornerRadius = 15
        textField.layer.masksToBounds = true
    }
}

// MARK: - Calculate BMI

extension BMIViewController {
    private func calculateBMI(height: Double, weight: Double) -> Double {
        return weight / pow(height, 2)
    }
}
