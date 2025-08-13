//
//  MBTICollectionViewCell.swift
//  MBTI
//
//  Created by HyoTaek on 8/14/25.
//

import UIKit
import SnapKit
import Then

final class MBTICollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "MBTICollectionViewCell"
    
    // MARK: - Component
    
    private let mbtiLabel = UILabel().then {
        $0.textColor = .gray
    }
    
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
        contentView.layer.cornerRadius = 22
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 1
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            mbtiLabel
        ].forEach(contentView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        mbtiLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with mbti: String) {
        mbtiLabel.text = mbti
    }
}
