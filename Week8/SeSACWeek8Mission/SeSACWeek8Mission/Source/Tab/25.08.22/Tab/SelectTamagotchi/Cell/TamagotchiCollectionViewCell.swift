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
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemYellow
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
