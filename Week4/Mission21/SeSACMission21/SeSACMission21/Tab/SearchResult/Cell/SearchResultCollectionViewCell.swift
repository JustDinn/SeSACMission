//
//  SearchResultCollectionViewCell.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/28/25.
//

import UIKit

final class SearchResultCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "SearchResultCollectionViewCell"
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
