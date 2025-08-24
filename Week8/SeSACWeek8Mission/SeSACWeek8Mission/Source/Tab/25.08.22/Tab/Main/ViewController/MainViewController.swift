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
            waterTextField
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
            $0.leading.equalTo(tamagotchiImageView)
        }
        
        riceCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(levelLabel)
            $0.centerX.equalTo(tamagotchiImageView)
        }
        
        waterCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(tamagotchiImageView)
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
    }
    
    // MARK: - Bind
    
    private func bind() {
        let input = MainViewModel.Input(
            viewWillAppear: viewWillAppearSubject.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.randomGreeting
            .bind(to: messageLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configure VC
    
    private func configureVC() {
        let nickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.value) ?? "대장"
        guard let tamagotchiName = UserDefaults.standard.string(forKey: UserDefaultsKey.tamagotchiName.value) else {
            return
        }
        guard let tamagotchiImage = UserDefaults.standard.string(forKey: UserDefaultsKey.tamagotchiImage.value) else {
            return
        }
        
        setProfileNaviBar("\(nickname)님의 다마고치")
        tamagotchiImageView.image = UIImage(named: tamagotchiImage)
        tamagotchiNameLabel.text = tamagotchiName
    }
}
