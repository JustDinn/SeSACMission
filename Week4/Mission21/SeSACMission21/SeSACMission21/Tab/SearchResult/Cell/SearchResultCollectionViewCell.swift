//
//  SearchResultCollectionViewCell.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/28/25.
//

import UIKit
import Kingfisher

final class SearchResultCollectionViewCell: UICollectionViewCell, InitialSetProtocol {
    
    // MARK: - Identifier
    
    static let identifier = "SearchResultCollectionViewCell"
    
    // MARK: - Component
    
    private let imageView = UIImageView().then {
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Hierarchy
    
    func setHierarchy() {
        [
            imageView
        ].forEach(contentView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    func setConstraints() {
        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(177)
        }
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with result: SearchResultModel) {
        imageView.kf.setImage(with: URL(string: result.itemImage))
    }
}
