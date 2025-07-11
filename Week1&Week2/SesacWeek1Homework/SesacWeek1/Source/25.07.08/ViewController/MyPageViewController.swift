//
//  MyPageViewController.swift
//  SesacWeek1Homework
//
//  Created by HyoTaek on 7/8/25.
//

import UIKit

class MyPageViewController: UIViewController {
    
    // MARK: - Components
    
    @IBOutlet var editNicknameTextField: UITextField!
    @IBOutlet var saveNickNameButton: UIBarButtonItem!
    @IBOutlet var naviBarTitle: UINavigationItem!
    @IBOutlet var nicknameTextField: UITextField!
    
    let alertController = UIAlertController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSaveNicknameButton()
        setNicknameTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        setNickname()
    }
    
    // MARK: - Set Title Label
    
    func setNickname() {
        if let nickname = UserDefaults.standard.string(forKey: "Nickname") {
            naviBarTitle.title = "\(nickname)님 이름 정하기"
        } else {
            naviBarTitle.title = "대장님의 다마고치"
        }
        naviBarTitle.titleView?.tintColor = .systemTeal
    }
    
    // MARK: - Set SaveButton
    
    func setSaveNicknameButton() {
        saveNickNameButton.title = "저장"
    }
    
    // MARK: - Set Nickname TextField
    
    func setNicknameTextField() {
        let border = CALayer()
        
        border.frame = CGRect(x: 0, y: nicknameTextField.frame.size.height, width: nicknameTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.systemTeal.cgColor
        
        nicknameTextField.contentHorizontalAlignment = .leading
        nicknameTextField.borderStyle = .none
        nicknameTextField.layer.addSublayer((border))
        nicknameTextField.textColor = .systemTeal
    }
    
    // MARK: - Action
    
    @IBAction func didTapSaveNicknameButton(_ sender: UIBarButtonItem) {
        if let nickname = editNicknameTextField.text {
            if nickname.count >= 2 && nickname.count <= 6 {
                UserDefaults.standard.set(editNicknameTextField.text, forKey: "Nickname")
                naviBarTitle.title = "\(nickname)님 이름 정하기"
                makeAlertController(alertVC: alertController, title: "안내", message: "닉네임이 저장되었습니다")
            } else {
                makeAlertController(alertVC: alertController, title: "안내", message: "닉네임은 2글자 이상, 6글자 이하만 설정 가능합니다")
            }
        }
    }
}
