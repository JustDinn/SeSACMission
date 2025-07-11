//
//  HyoflixViewController.swift
//  SeSAC7Week1Remind
//
//  Created by HyoTaek on 7/6/25.
//

import UIKit

class HyoflixViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var buttonStackView: UIStackView!
    @IBOutlet var contactButton: UIButton!
    @IBOutlet var passwordButton: UIButton!
    @IBOutlet var nicknameButton: UIButton!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var codeButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet var moreInfoButton: UIButton!
    @IBOutlet var toggleSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        makeTitleLabelUI(label: titleLabel, title: "HYOFLIX")
        setStackView()
        makeStackViewButtons()
        makeButtonUI(button: moreInfoButton, title: "추가 정보 입력", textColor: .white, backgroundColor: .clear)
    }
    
    private func makeTitleLabelUI(label: UILabel, title: String) {
        label.text = title
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 25, weight: .black)
        label.textAlignment = .center
    }
    
    private func setStackView() {
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 15
        buttonStackView.alignment = .fill
    }
    
    private func makeStackViewButtons() {
        makeButtonUI(button: contactButton, title: "이메일 또는 전화번호 버튼")
        makeButtonUI(button: passwordButton, title: "비밀번호 버튼")
        makeButtonUI(button: nicknameButton, title: "닉네임 버튼")
        makeButtonUI(button: locationButton, title: "위치 버튼")
        makeButtonUI(button: codeButton, title: "추천 코드 버튼")
        makeButtonUI(button: signUpButton, title: "회원 가입", textColor: .black, backgroundColor: .white)
    }
    
    private func makeButtonUI(button: UIButton, title: String, textColor: UIColor = .white, backgroundColor: UIColor = .darkGray) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
    }
}
