//
//  TamagotchiDetailViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/25/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class TamagotchiDetailViewController: UIViewController {

    // MARK: - Property
    
    private let viewModel = TamagotchiDetailViewModel()
    private let disposeBag = DisposeBag()
    private var selectedTamagotchiName = ""
    private let selectTappedSubject = PublishSubject<String>()
    
    // MARK: - Component
    
    private let tamagotchiInfoView = UIView().then {
        $0.backgroundColor = .main
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .tint
        $0.layer.cornerRadius = 60
        $0.layer.masksToBounds = true
    }
    
    private let tamagotchiImageView = UIImageView().then {
        $0.layer.cornerRadius = 59
        $0.layer.masksToBounds = true
    }
    
    private let tamagotchiNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .tint
        $0.backgroundColor = .skyBlue
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.tint.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let borderLine = UIView().then {
        $0.backgroundColor = .tint
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .medium)
        $0.textColor = .tint
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let buttonTopBorder = UIView().then {
        $0.backgroundColor = .tint
    }
    
    private lazy var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.tint, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        $0.backgroundColor = .skyBlue
    }
    
    private lazy var selectButton = UIButton().then {
        $0.setTitle("변경하기", for: .normal)
        $0.setTitleColor(.tint, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setConstraints()
        bind()
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            tamagotchiInfoView
        ].forEach(view.addSubview)
        
        [
            containerView,
            tamagotchiNameLabel,
            borderLine,
            descriptionLabel,
            buttonTopBorder,
            cancelButton,
            selectButton
        ].forEach(tamagotchiInfoView.addSubview)
        
        [
            tamagotchiImageView
        ].forEach(containerView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        tamagotchiInfoView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(400)
        }
        
        containerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(60)
            $0.size.equalTo(120)
        }
        
        tamagotchiImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(118)
        }
        
        tamagotchiNameLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(16)
            $0.centerX.equalTo(containerView)
        }
        
        borderLine.snp.makeConstraints {
            $0.top.equalTo(tamagotchiNameLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(45)
            $0.height.equalTo(1)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(45)
        }
        
        buttonTopBorder.snp.makeConstraints {
            $0.bottom.equalTo(cancelButton.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        cancelButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
        
        selectButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        let input = TamagotchiDetailViewModel.Input(
            cancelTapped: cancelButton.rx.tap,
            selectTapped: selectTappedSubject
        )
        let output = viewModel.transform(input: input)
        
        output.dismiss
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        selectButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.selectTappedSubject.onNext(owner.selectedTamagotchiName)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configure VC
    
    func configureVC(with tamagotchi: TamagotchiModel) {
        selectedTamagotchiName = tamagotchi.name
        tamagotchiImageView.image = UIImage(named: tamagotchi.image)
        tamagotchiNameLabel.text = tamagotchi.name
        descriptionLabel.text = tamagotchi.description
    }
}
