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
    
    private let mallNameLabel = UILabel().then {
        $0.setLabelUI("", size: 13, weight: .medium, color: .white)
    }
    
    private let titleLabel = UILabel().then {
        $0.setLabelUI("", size: 14, weight: .bold, color: .white)
        $0.numberOfLines = 2
    }
    
    private let priceLabel = UILabel().then {
        $0.setLabelUI("", size: 16, weight: .bold, color: .white)
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
            imageView,
            mallNameLabel,
            titleLabel,
            priceLabel
        ].forEach(contentView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    func setConstraints() {
        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(177)
        }
        
        mallNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(mallNameLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with result: SearchResultModel) {
        imageView.kf.setImage(with: URL(string: result.itemImage))
        mallNameLabel.text = result.mallName
        titleLabel.text = result.title
        priceLabel.text = result.itemPrice
    }
}
