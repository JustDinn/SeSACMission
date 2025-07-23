//
//  LottoNumberCollectionViewCell.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/24/25.
//

import UIKit

final class LottoNumberCollectionViewCell: UICollectionViewCell, InitialSetProtocol {
    
    // MARK: - Identifier
    
    static let identifier = "LottoNumberCollectionViewCell"
    
    // MARK: - Component
    
    private let lottoNumberLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.layer.cornerRadius = 18
        label.layer.masksToBounds = true
        
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAddView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set AddView
    
    func setAddView() {
        [
            lottoNumberLabel
        ].forEach(contentView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    func setConstraints() {
        lottoNumberLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
