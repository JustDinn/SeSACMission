//
//  SettingTableViewCell.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/22/25.
//

import UIKit
import SnapKit
import Then

final class SettingTableViewCell: UITableViewCell, ReuseIdentifier {
    
    // MARK: - Component
    
    private let settingButton = UIButton().then {
        $0.setTitle("test", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
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
        [
            settingButton
        ].forEach(contentView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        settingButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
