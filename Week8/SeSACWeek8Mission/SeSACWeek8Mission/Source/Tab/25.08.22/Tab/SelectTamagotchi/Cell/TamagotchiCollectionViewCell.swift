//
//  TamagotchiCollectionViewCell.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/24/25.
//

import UIKit
import SnapKit
import Then

final class TamagotchiCollectionViewCell: UICollectionViewCell, ReuseIdentifier {
    
    // MARK: - Component
    
    private let containerView = UIView().then {
        $0.backgroundColor = .tint
        $0.layer.cornerRadius = 50
        $0.layer.masksToBounds = true
    }
    
    private let tamagotchiImageView = UIImageView().then {
        $0.layer.cornerRadius = 49
        $0.layer.masksToBounds = true
    }
    
    private let tamagotchiNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .semibold)
        $0.textColor = .tint
        $0.backgroundColor = .skyBlue
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.tint.cgColor
        $0.layer.borderWidth = 1
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            containerView,
            tamagotchiNameLabel
        ].forEach(contentView.addSubview)
        
        [
            tamagotchiImageView
        ].forEach(containerView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        containerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        tamagotchiImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(98)
        }
        
        tamagotchiNameLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(8)
            $0.centerX.equalTo(containerView)
        }
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with tamagotchi: TamagotchiModel) {
        tamagotchiImageView.image = UIImage(named: tamagotchi.image)
        tamagotchiNameLabel.text = tamagotchi.name
    }
}
