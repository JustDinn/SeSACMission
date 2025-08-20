//
//  RootTableTableViewCell.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/20/25.
//

import UIKit
import SnapKit

final class RootTableTableViewCell: UITableViewCell {

    // MARK: - Identifier
    
    static let identifier = "RootTableTableViewCell"
    
    // MARK: - Component
    
    let label = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setHierarchy()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        contentView.addSubview(label)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
