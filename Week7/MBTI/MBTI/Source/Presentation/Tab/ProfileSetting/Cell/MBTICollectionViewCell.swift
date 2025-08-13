//
//  MBTICollectionViewCell.swift
//  MBTI
//
//  Created by HyoTaek on 8/14/25.
//

import UIKit

final class MBTICollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "MBTICollectionViewCell"
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
