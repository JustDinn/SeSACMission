//
//  RecommendCollectionViewCell.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/29/25.
//

import UIKit

final class RecommendCollectionViewCell: UICollectionViewCell {

    // MARK: - Identifier
    
    static let identifier = "RecommendCollectionViewCell"
    
    // MARK: - Component
    
    private let recommendImageView = UIImageView().then {
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
     
        setUI()
        setAddView()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        contentView.backgroundColor = .black
    }
    
    // MARK: - Set AddView
    
    private func setAddView() {
        [
            recommendImageView
        ].forEach(contentView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        recommendImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
