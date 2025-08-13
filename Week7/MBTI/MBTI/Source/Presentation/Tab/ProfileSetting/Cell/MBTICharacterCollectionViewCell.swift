//
//  MBTICharacterCollectionViewCell.swift
//  MBTI
//
//  Created by HyoTaek on 8/14/25.
//

import UIKit
import SnapKit
import Then

final class MBTICharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "MBTICharacterCollectionViewCell"
    
    // MARK: - Component
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        contentView.layer.cornerRadius = contentView.frame.width / 2
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 1
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            
        ].forEach(contentView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        
    }
}
