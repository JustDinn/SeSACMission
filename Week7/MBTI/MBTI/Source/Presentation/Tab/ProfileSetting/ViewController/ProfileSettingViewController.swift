//
//  ProfileSettingViewController.swift
//  MBTI
//
//  Created by HyoTaek on 8/13/25.
//

import UIKit
import SnapKit
import Then

final class ProfileSettingViewController: UIViewController {

    // MARK: - Property
    
    private let profileSettingViewModel = ProfileSettingViewModel()
    
    // MARK: - Component
    
    private let profileImageBackgroundView = UIView().then {
        $0.backgroundColor = .main
        $0.layer.cornerRadius = 65
        $0.layer.masksToBounds = true
    }
    
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 60
        $0.layer.masksToBounds = true
        $0.backgroundColor = .white
    }
    
    private let mbtiSettingView = UIView()
    
    private let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력해주세요 :)"
    }
    
    private let borderLine = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let validResultLabel = UILabel().then {
        $0.text = "사용할 수 있는 닉네임이에요"
        $0.textColor = .red
    }
    
    private let mbtiTitleLabel = UILabel().then {
        $0.text = "MBTI"
        $0.font = .systemFont(ofSize: 20, weight: .black)
    }
    
    private lazy var mbtiCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 44, height: 44)
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.minimumLineSpacing = 12
        
        $0.collectionViewLayout = flowLayout
        $0.register(MBTICollectionViewCell.self, forCellWithReuseIdentifier: MBTICollectionViewCell.identifier)
        $0.dataSource = self
    }
    
    private lazy var mbtiCharacterCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let flowLayout = UICollectionViewFlowLayout()
        
        let numberOfColumns: CGFloat = 4
        let horizontalPadding: CGFloat = 20
        let itemSpacing: CGFloat = 16
        
        let width = (view.frame.width - (horizontalPadding * 2) - (itemSpacing * 3)) / 4
        let height = width
        
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        
        $0.collectionViewLayout = flowLayout
        $0.register(MBTICharacterCollectionViewCell.self, forCellWithReuseIdentifier: MBTICharacterCollectionViewCell.identifier)
        $0.dataSource = self
        
        $0.isHidden = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setConstraints()
        bind()
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            profileImageBackgroundView,
            mbtiSettingView,
            mbtiCharacterCollectionView
        ].forEach(view.addSubview)
        
        [
            profileImageView
        ].forEach(profileImageBackgroundView.addSubview)
        
        [
            nicknameTextField,
            borderLine,
            validResultLabel,
            mbtiTitleLabel,
            mbtiCollectionView
        ].forEach(mbtiSettingView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        profileImageBackgroundView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(130)
        }
        
        profileImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(120)
        }
        
        mbtiSettingView.snp.makeConstraints {
            $0.top.equalTo(profileImageBackgroundView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(5)
        }
        
        borderLine.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        validResultLabel.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom).offset(16)
            $0.leading.equalTo(nicknameTextField)
        }
        
        mbtiTitleLabel.snp.makeConstraints {
            $0.top.equalTo(validResultLabel.snp.bottom).offset(40)
            $0.leading.equalTo(borderLine.snp.leading).inset(8)
        }
        
        mbtiCollectionView.snp.makeConstraints {
            $0.top.equalTo(mbtiTitleLabel)
            $0.trailing.equalTo(borderLine.snp.trailing).inset(8)
            $0.width.equalTo(212)
            $0.height.equalTo(100)
        }
        
        mbtiCharacterCollectionView.snp.makeConstraints {
            $0.top.equalTo(profileImageBackgroundView.snp.bottom).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(267.5)
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        profileSettingViewModel.output.randomImage.bind { [weak self] randomImage in
            guard let self = self else { return }
            
            profileImageView.image = UIImage(named: randomImage)
        }
    }
}

// MARK: - UICollectionView DataSource

extension ProfileSettingViewController: UICollectionViewDataSource {
    
    // 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == mbtiCollectionView {
            return profileSettingViewModel.output.mbtiList.value.count  // MBTI 문자 collectionView
        } else {
            return 12    // MBTI 캐릭터 collectionView
        }
    }
    
    // 셀 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // MBTI 문자 collectionView
        if collectionView == mbtiCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MBTICollectionViewCell.identifier, for: indexPath) as! MBTICollectionViewCell
            cell.configureCell(with: profileSettingViewModel.output.mbtiList.value[indexPath.item])
            
            return cell
        }
        // MBTI 캐릭터 collectionView
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MBTICharacterCollectionViewCell.identifier, for: indexPath) as! MBTICharacterCollectionViewCell
            
            return cell
        }
    }
}
