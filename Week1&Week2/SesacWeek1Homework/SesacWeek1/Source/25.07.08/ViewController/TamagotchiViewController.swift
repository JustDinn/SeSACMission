//
//  TamagotchiViewController.swift
//  SesacWeek1Homework
//
//  Created by HyoTaek on 7/8/25.
//

import UIKit

struct User {
    var nickname: String
    var level: Int
    var rice: Int
    var water: Int
    var sum: Int
}

class TamagotchiViewController: UIViewController {

    // MARK: - Properties
    
    var user = User(nickname: "", level: 1, rice: 0, water: 0, sum: 0)
    let greetingMessage = [
        "밥 주세요 응애",
        "오늘도 유튜브만 보다가 잘 건 아니죠?^^",
        "깃허브의 잔디들이 말라가고 있어요. 분발하세요",
        "기다리다 지쳤어요 땡벌"
    ]
    
    // MARK: - Components
    
    let alertController = UIAlertController()
    
    @IBOutlet var myPageButton: UIBarButtonItem!
    @IBOutlet var tamaNaviBar: UINavigationItem!
    
    @IBOutlet var bubbleImageView: UIImageView!
    @IBOutlet var greetingMessageLabel: UILabel!
    @IBOutlet var characterImageVIew: UIImageView!
    
    @IBOutlet var characterLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var riceCountingLabel: UILabel!
    @IBOutlet var waterCountingLabel: UILabel!
    
    @IBOutlet var riceTextField: UITextField!
    @IBOutlet var waterTextField: UITextField!
    
    @IBOutlet var riceButton: UIButton!
    @IBOutlet var waterButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        setMyPageButton()
        setCharacterImageView()
        setLabelUI()
        setGreetingLabel()
        setRiceWaterTextField()
        setRiceWaterButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNickname()
        setBubbleImageView()
    }
    
    // MARK: - Set MyPageButon
    
    func setMyPageButton() {
        myPageButton.title = ""
        myPageButton.image = UIImage(systemName: "person.circle")
    }
    
    // MARK: - Set Nickname
    
    func setNickname() {
        if let nickname = UserDefaults.standard.string(forKey: "Nickname") {
            tamaNaviBar.title = "\(nickname)님의 다마고치"
            tamaNaviBar.titleView?.tintColor = .systemTeal
            self.user.nickname = nickname
        } else {
            setDefaultNickname()
            self.user.nickname = "대장"
        }
    }
    
    func setDefaultNickname() {
        UserDefaults.standard.set("대장", forKey: "Nickname")
    }
    
    // MARK: - Set Bubble ImageView
    
    func setBubbleImageView() {
        guard let randomMessage = greetingMessage.randomElement() else {
            makeAlertController(alertVC: alertController, title: "안내", message: "환영 메시지 오류입니다. 잠시만 기다려주세요. :D")
            return
        }
        let nickname = "\(self.user.nickname)님"
        var fullMessage = [nickname, randomMessage]
        fullMessage.shuffle()
        
        bubbleImageView.contentMode = .scaleAspectFit
        bubbleImageView.image = UIImage(named: "bubble")
        greetingMessageLabel.text = "\(fullMessage[0]) \(fullMessage[1])"
    }
    
    // MARK: - Set Greeting Label
    
    func setGreetingLabel() {
        greetingMessageLabel.numberOfLines = 0
        greetingMessageLabel.textColor = .systemTeal
    }
    
    // MARK: - Set Character ImageView
    
    func setCharacterImageView() {
        characterImageVIew.image = UIImage(named: "2-\(min(user.level, 9))")
    }
    
    // MARK: - Set LabelUI
    
    func setLabelUI() {
        setCharacterlabel()
        setLevelLabel()
        setRiceLabel()
        setWaterLabel()
    }
    
    // MARK: - Set Character Label
    
    func setCharacterlabel() {
        characterLabel.text = "방실방실 다마고치"
        characterLabel.textColor = .systemTeal
        characterLabel.textAlignment = .center
        characterLabel.layer.borderWidth = 0.5
        characterLabel.layer.borderColor = UIColor.systemTeal.cgColor
        characterLabel.layer.cornerRadius = 5
        characterLabel.layer.masksToBounds = true
    }
    
    // MARK: - Set Level Label
    
    func setLevelLabel() {
        levelLabel.text = "LV\(user.level) ·"
        levelLabel.textColor = .systemTeal
    }
    
    // MARK: - Set Rice Label
    
    func setRiceLabel() {
        riceCountingLabel.text = "밥알 \(user.rice)개 ·"
        riceCountingLabel.textColor = .systemTeal
    }
    
    // MARK: - Set Water Label
    
    func setWaterLabel() {
        waterCountingLabel.text = "물방울 \(user.water)개"
        waterCountingLabel.textColor = .systemTeal
    }
    
    // MARK: - Set Rice, Water TextField
    
    func setRiceWaterTextField() {
        let textFields = [riceTextField, waterTextField]
        let textFieldText = ["밥주세용", "물주세용"]
        
        for (i, textField) in textFields.enumerated() {
            if let tf = textField {
                let border = CALayer()
                
                border.frame = CGRect(x: 0, y: tf.frame.size.height - 5, width: tf.frame.width, height: 1)
                border.backgroundColor = UIColor.systemTeal.cgColor
                
                tf.textAlignment = .center
                tf.textColor = .systemTeal
                tf.placeholder = textFieldText[i]
                tf.contentHorizontalAlignment = .leading
                tf.borderStyle = .none
                tf.layer.addSublayer((border))
            }
        }
    }
    
    // MARK: - Set Rice, Water Button
    
    func setRiceWaterButton() {
        let buttons = [riceButton, waterButton]
        let buttonTitle = ["밥먹기", "물먹기"]
        let buttonImage = ["leaf.circle", "drop.circle"]
        
        for (i, button) in buttons.enumerated() {
            if let btn = button {
                btn.setTitle(buttonTitle[i], for: .normal)
                btn.setImage(UIImage(systemName: buttonImage[i]), for: .normal)
                btn.layer.borderColor = UIColor.systemTeal.cgColor
                btn.layer.borderWidth = 1
                btn.layer.cornerRadius = 5
                btn.layer.masksToBounds = true
            }
        }
    }
    
    // MARK: - 레벨 계산
    
    func calculateLevel() -> Int {
        let riceLevel = user.rice / 5
        let waterLevel = user.water / 2
        let result = (riceLevel + waterLevel) / 10
        
        return result
    }
    
    // MARK: - Action
    
    @IBAction func didTapRiceButton(_ sender: UIButton) {
        let riceText = riceTextField.text!
        
        if let riceCount = Int(riceText) {
            if riceCount < 0 || riceCount > 99 {
                makeAlertController(alertVC: alertController, title: "안내", message: "다마고치가 한번에 먹을 수 있는 밥의 양은 0 ~ 99개입니다.")
                return
            } else {
                if user.level >= 10 {
                    makeAlertController(alertVC: alertController, title: "안내", message: "다마고치의 최대 레벨은 10레벨입니다.")
                    user.level = 10
                    return
                }
                let validRice = (10 - user.level) * 50
                
                if riceCount > validRice {
                    user.rice += validRice
                } else {
                    user.rice += riceCount
                }
            }
        } else if riceText.isEmpty {
            user.rice += 1
        } else {
            makeAlertController(alertVC: alertController, title: "안내", message: "숫자만 입력해주세요")
            return
        }
        
        let result = calculateLevel()
        user.level = max(result, 1)
        
        setRiceLabel()
        setLevelLabel()
        setCharacterImageView()
        setBubbleImageView()
        
        UserDefaults.standard.set(user.level, forKey: "Level")
        UserDefaults.standard.set(user.rice, forKey: "Rice")
    }
    
    @IBAction func didTapWaterButton(_ sender: UIButton) {
        let waterText = waterTextField.text!
        
        if let waterCount = Int(waterText) {
            if waterCount < 0 || waterCount > 99 {
                makeAlertController(alertVC: alertController, title: "안내", message: "다마고치가 한번에 먹을 수 있는 물방울의 양은 0 ~ 99개입니다.")
                return
            } else {
                if user.level >= 10 {
                    makeAlertController(alertVC: alertController, title: "안내", message: "다마고치의 최대 레벨은 10레벨입니다.")
                    user.level = 10
                    return
                }
                let validWater = (10 - user.level) * 20
                
                if waterCount > validWater {
                    user.water += validWater
                } else {
                    user.water += waterCount
                }
            }
        } else if waterText.isEmpty {
            user.water += 1
        } else {
            makeAlertController(alertVC: alertController, title: "안내", message: "숫자만 입력해주세요")
            return
        }
        
        let result = calculateLevel()
        user.level = max(result, 1)
        
        setWaterLabel()
        setLevelLabel()
        setCharacterImageView()
        setBubbleImageView()
        
        UserDefaults.standard.set(user.level, forKey: "Level")
        UserDefaults.standard.set(user.water, forKey: "Water")
    }
    
//    @IBAction func dismissToTamaVC(_ segud: UIStoryboardSegue) {
//        print("타마로 돌아가기")
//    }
}
