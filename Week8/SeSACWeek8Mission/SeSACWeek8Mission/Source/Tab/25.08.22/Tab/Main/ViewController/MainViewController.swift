//
//  MainViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/25/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {

    // MARK: - Property
    
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    private let viewWillAppearSubject = PublishSubject<Void>()
    private let riceButtonSubject = PublishSubject<Int>()
    private let waterButtonSubject = PublishSubject<Int>()

    // MARK: - Component
    
    private let bubbleImageView = UIImageView().then {
        $0.image = UIImage(named: "bubble")
    }
    
    private let messageLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .tint
        $0.numberOfLines = 0
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .tint
        $0.layer.cornerRadius = 75
        $0.layer.masksToBounds = true
    }
    
    private let tamagotchiImageView = UIImageView().then {
        $0.layer.cornerRadius = 72
        $0.layer.masksToBounds = true
    }
    
    private let tamagotchiNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .tint
        $0.backgroundColor = .skyBlue
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.tint.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let levelLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .medium)
        $0.textColor = .tint
    }
    
    private let riceCountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .medium)
        $0.textColor = .tint
    }
    
    private let waterCountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .medium)
        $0.textColor = .tint
    }
    
    private let riceTextField = UITextField().then {
        $0.placeholder = "밥주세용"
        $0.textColor = .tint
    }
    
    private let waterTextField = UITextField().then {
        $0.placeholder = "물주세용"
        $0.textColor = .tint
    }
    
    private let riceButton = UIButton().then {
        $0.setTitle("밥먹기", for: .normal)
        $0.setTitleColor(.tint, for: .normal)
        $0.layer.borderColor = UIColor.tint.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    
    private let waterButton = UIButton().then {
        $0.setTitle("물먹기", for: .normal)
        $0.setTitleColor(.tint, for: .normal)
        $0.layer.borderColor = UIColor.tint.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setConstraints()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureVC()
        updateTamagotchiImage()
        viewWillAppearSubject.onNext(())
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            bubbleImageView,
            messageLabel,
            containerView,
            tamagotchiNameLabel,
            levelLabel,
            riceCountLabel,
            waterCountLabel,
            riceTextField,
            waterTextField,
            riceButton,
            waterButton
        ].forEach(view.addSubview)
        
        [
            tamagotchiImageView
        ].forEach(containerView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        bubbleImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(containerView.snp.top).offset(-16)
        }
        
        messageLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(bubbleImageView.snp.horizontalEdges).inset(20)
            $0.centerY.equalTo(bubbleImageView)
        }
        
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(150)
        }
        
        tamagotchiImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(144)
        }
        
        tamagotchiNameLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(16)
            $0.centerX.equalTo(containerView)
        }
        
        levelLabel.snp.makeConstraints {
            $0.top.equalTo(tamagotchiNameLabel.snp.bottom).offset(20)
            $0.leading.equalTo(tamagotchiImageView).offset(-30)
        }
        
        riceCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(levelLabel)
            $0.centerX.equalTo(tamagotchiImageView)
        }
        
        waterCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(tamagotchiImageView).offset(30)
            $0.centerY.equalTo(levelLabel)
        }
        
        riceTextField.snp.makeConstraints {
            $0.top.equalTo(waterCountLabel.snp.bottom).offset(40)
            $0.leading.equalTo(tamagotchiImageView.snp.leading).offset(-15)
            $0.width.equalTo(150)
        }
        
        waterTextField.snp.makeConstraints {
            $0.top.equalTo(riceTextField.snp.bottom).offset(30)
            $0.leading.equalTo(riceTextField)
            $0.width.equalTo(150)
        }
        
        riceButton.snp.makeConstraints {
            $0.leading.equalTo(riceTextField.snp.trailing).offset(12)
            $0.centerY.equalTo(riceTextField)
            $0.width.equalTo(100)
            $0.height.equalTo(44)
        }
        
        waterButton.snp.makeConstraints {
            $0.top.equalTo(riceButton.snp.bottom).offset(12)
            $0.leading.equalTo(riceButton)
            $0.width.equalTo(100)
            $0.height.equalTo(44)
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        let input = MainViewModel.Input(
            viewWillAppear: viewWillAppearSubject.asObservable(),
            riceButtonTapped: riceButtonSubject.asObservable(),
            waterButtonTapped: waterButtonSubject.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.randomGreeting
            .bind(with: self) { owner, greeting in
                owner.messageLabel.text = greeting
            }
            .disposed(by: disposeBag)
        
        output.level
            .bind(with: self) { owner, level in
                owner.levelLabel.text = "LV.\(level)"
                owner.updateTamagotchiImage(level: level)
            }
            .disposed(by: disposeBag)
        
        output.riceCount
            .bind(with: self) { owner, count in
                owner.riceCountLabel.text = "밥알 \(count)개"
            }
            .disposed(by: disposeBag)
        
        output.waterCount
            .bind(with: self) { owner, count in
                owner.waterCountLabel.text = "물방울 \(count)개"
            }
            .disposed(by: disposeBag)
        
        riceButton.rx.tap
            .bind(with: self) { owner, _ in
                let riceText = owner.riceTextField.text ?? ""
                let riceAmount = riceText.isEmpty ? 1 : (Int(riceText) ?? 1)
                
                if riceAmount <= 99 {
                    owner.riceButtonSubject.onNext(riceAmount)
                }
                owner.riceTextField.text = ""
            }
            .disposed(by: disposeBag)
        
        waterButton.rx.tap
            .bind(with: self) { owner, _ in
                let waterText = owner.waterTextField.text ?? ""
                let waterAmount = waterText.isEmpty ? 1 : (Int(waterText) ?? 1)
                
                if waterAmount <= 49 {
                    owner.waterButtonSubject.onNext(waterAmount)
                }
                owner.waterTextField.text = ""
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configure VC
    
    private func configureVC() {
        let nickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.value) ?? "대장"
        guard let tamagotchiName = UserDefaults.standard.string(forKey: UserDefaultsKey.tamagotchiName.value) else {
            return
        }
        
        setProfileNaviBar("\(nickname)님의 다마고치")
        tamagotchiNameLabel.text = tamagotchiName
    }
    
    private func updateTamagotchiImage(level: Int) {
        guard let tamagotchiName = UserDefaults.standard.string(forKey: UserDefaultsKey.tamagotchiName.value) else {
            return
        }
        
        let level = max(1, min(level, 9))
        var imageName = ""
        
        switch tamagotchiName {
        case "따끔따끔 다마고치":
            imageName = "1-\(level)"
        case "방실방실 다마고치":
            imageName = "2-\(level)"
        case "반짝반짝 다마고치":
            imageName = "3-\(level)"
        default:
            imageName = "1-1"
        }
        
        tamagotchiImageView.image = UIImage(named: imageName)
    }
    
    private func updateTamagotchiImage() {
        guard let tamagotchiName = UserDefaults.standard.string(forKey: UserDefaultsKey.tamagotchiName.value) else {
            return
        }
        
        let currentLevel = UserDefaults.standard.integer(forKey: UserDefaultsKey.level.value)
        let level = max(1, min(currentLevel, 9))
        var imageName = ""
        
        switch tamagotchiName {
        case "따끔따끔 다마고치":
            imageName = "1-\(level)"
        case "방실방실 다마고치":
            imageName = "2-\(level)"
        case "반짝반짝 다마고치":
            imageName = "3-\(level)"
        default:
            imageName = "1-1"
        }
        
        tamagotchiImageView.image = UIImage(named: imageName)
    }
}
