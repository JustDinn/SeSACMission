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
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
