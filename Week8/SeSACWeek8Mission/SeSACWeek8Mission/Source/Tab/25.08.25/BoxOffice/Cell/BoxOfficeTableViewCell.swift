//
//  BoxOfficeTableViewCell.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

import UIKit
import SnapKit
import Then

final class BoxOfficeTableViewCell: UITableViewCell, ReuseIdentifier {
    
    // MARK: - Component
    
    private let titleLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .main
        setHierarchy()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            titleLabel
        ].forEach(contentView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    
    func configureCell(with title: String) {
        titleLabel.text = title
    }
}
