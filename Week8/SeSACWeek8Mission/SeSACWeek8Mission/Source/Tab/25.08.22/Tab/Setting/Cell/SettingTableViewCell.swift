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
    
    private let iconImageView = UIImageView().then {
        $0.tintColor = .tint
    }
    
    private let settingTitleLabel = UILabel()
    
    private let nicknameLabel = UILabel().then {
        $0.text = "asdf"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .tint
//        $0.isHidden = true
    }
    
    private let nextImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .gray
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setHierarchy()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        contentView.backgroundColor = .main
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            iconImageView,
            settingTitleLabel,
            nicknameLabel,
            nextImageView
        ].forEach(contentView.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        settingTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(16)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(nextImageView.snp.leading).offset(-8)
        }
        
        nextImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with settingData: SettingModel) {
        iconImageView.image = UIImage(systemName: settingData.icon)
        settingTitleLabel.text = settingData.title
    }
}
