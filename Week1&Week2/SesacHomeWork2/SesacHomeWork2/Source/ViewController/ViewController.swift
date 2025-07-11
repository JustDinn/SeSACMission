//
//  ViewController.swift
//  SesacHomeWork2
//
//  Created by HyoTaek on 7/1/25.
//

import UIKit
import SafariServices

final class ViewController: UIViewController {

    // MARK: - Properties
    
    private var isHiddenTextView = true
    
    // MARK: - Components
    
    @IBOutlet var logoButton: UIButton!
    @IBOutlet var logoImageButton: UIButton!
    @IBOutlet var emailOrContactTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var moreInfoLabel: UILabel!
    @IBOutlet var moreInfoSwitch: UISwitch!
    @IBOutlet var moreInfoTextView: UITextView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLogoImageButton()
        setLogoButton()
        setEmailOrContactTextField()
        setPasswordTextField()
        setNicknameTextField()
        setLocationTextField()
        setCodeTextField()
        setSignUpButton()
        setMoreInfoLabel()
        setMoreInfoSwitch()
        setMoreInfoTextView()
    }

    // MARK: - Component Setting
    
    // Set ImageView
    private func setLogoImageButton() {
        logoImageButton.setImage(UIImage(named: "Sesac"), for: .normal)
    }
    
    // Set LogoButton
    private func setLogoButton() {
        let title = """
                        Seoul
                        Software
                        ACademy
                    """
        logoButton.setTitle(title, for: .normal)
        logoButton.setTitleColor(.systemGreen, for: .normal)
    }
    
    // Set EmailOrContactTextField
    private func setEmailOrContactTextField() {
        emailOrContactTextField.placeholder = "이메일 주소 또는 전화번호(- 제외 숫자만 입력)"
        emailOrContactTextField.textColor = .systemBlue
    }
    
    // Set PasswordTextField
    private func setPasswordTextField() {
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
    }
    
    // Set NicknameTextField
    private func setNicknameTextField() {
        nicknameTextField.placeholder = "닉네임"
    }
    
    // Set LocationTextField
    private func setLocationTextField() {
        locationTextField.placeholder = "위치"
    }
    
    // Set CodeTextField
    private func setCodeTextField() {
        codeTextField.placeholder = "추천인 코드"
        codeTextField.keyboardType = .namePhonePad
    }
    
    // Set SignUpButton
    private func setSignUpButton() {
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .systemGreen
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.masksToBounds = true
    }
    
    // Set MoreInfoLabel
    private func setMoreInfoLabel() {
        moreInfoLabel.text = "추가 정보 입력"
    }
    
    // Set MoreInfoSwitch
    private func setMoreInfoSwitch() {
        moreInfoSwitch.isOn = false
        moreInfoSwitch.onTintColor = .orange
    }
    
    // Set MoreInfoTextView
    private func setMoreInfoTextView() {
        moreInfoTextView.isHidden = true
    }
    
    // MARK: - Action Setting
    
    // LogoImageButton Action
    @IBAction func didTapLogoImageButton(_ sender: UIButton) {
        guard let sesacUrl = URL(string: "https://sesac.seoul.kr/course/active/detail.do?courseActiveSeq=2942&srchCategoryTypeCd=&courseMasterSeq=378&currentMenuId=900002001") else {
            print("잘못된 url입니다.")
            return
        }
        let sesacSafariView: SFSafariViewController = SFSafariViewController(url: sesacUrl)
        self.present(sesacSafariView, animated: true, completion: nil)
    }
    
    // TextField Focus Action
    @IBAction func didFocusTextField(_ sender: UITextField) {
        emailOrContactTextField.layer.borderColor = UIColor.systemBlue.cgColor
        emailOrContactTextField.layer.borderWidth = 1.5
        emailOrContactTextField.backgroundColor = .white
        emailOrContactTextField.layer.cornerRadius = 5
        emailOrContactTextField.layer.masksToBounds = true
    }
    
    // Tap Return TextField
    @IBAction func didTapReturnTextField(_ sender: UITextField) {
    }
    
    // UISwitch Action
    @IBAction func didOnSwitch(_ sender: UISwitch) {
        isHiddenTextView.toggle()
        moreInfoTextView.isHidden = isHiddenTextView
    }
    
    // ConfirmButton Action
    @IBAction func didTapConfirmButton(_ sender: UIButton) {
        let isValidEmail = isValidEmail()
        let isValidContact = isValidContact()
        let isEmptyTextField = isEmpty()
        
        if !isValidEmail && !isValidContact {
            print("이메일 또는 전화번호 양식이 틀림")
        }
        if isEmptyTextField {
            print("텍스트필드중 하나 이상이 공란임")
        }
        
        print("이메일 또는 전화번호: \(String(describing: emailOrContactTextField.text))")
        print("비밀번호: \(String(describing: passwordTextField.text))")
        print("닉네임: \(String(describing: nicknameTextField.text))")
        print("위치: \(String(describing: locationTextField.text))")
        print("추천인 코드: \(String(describing: codeTextField.text))")
        
        if !isHiddenTextView {
            print("추가 정보: \(String(describing: moreInfoTextView.text))")
        }
    }
    
    // MARK: - Validate
    
    private func isValidEmail() -> Bool {
        guard let email = emailOrContactTextField.text else {
            print("이메일 옵셔널 바인딩 실패")
            return false
        }
        let emailRegex = "[A-Za-z0-9]+@[A-Za-z]+\\.[A-Za-z]{2,10}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return predicate.evaluate(with: email)
    }
    
    private func isValidContact() -> Bool {
        guard let contact = emailOrContactTextField.text else {
            print("전화번호 옵셔널 바인딩 실패")
            return false
        }
        let contactRegex = "^(010)\\d{4}\\d{4}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", contactRegex)
        
        return predicate.evaluate(with: contact)
    }
    
    private func isEmpty() -> Bool {
        let isEmptyContact = emailOrContactTextField.text?.isEmpty ?? true
        let isEmptyPassword = passwordTextField.text?.isEmpty ?? true
        let isEmptyNickname = nicknameTextField.text?.isEmpty ?? true
        let isEmptyLocation = locationTextField.text?.isEmpty ?? true
        let isEmptyCode = codeTextField.text?.isEmpty ?? true
        
        if isEmptyContact ||
            isEmptyPassword ||
            isEmptyNickname ||
            isEmptyLocation ||
            isEmptyCode {
            return true
        } else {
            return false
        }
    }
}
