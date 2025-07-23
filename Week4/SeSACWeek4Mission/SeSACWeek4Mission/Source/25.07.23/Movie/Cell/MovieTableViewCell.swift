//
//  MovieTableViewCell.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/24/25.
//

import UIKit

final class MovieTableViewCell: UITableViewCell, InitialSetProtocol {
    
    // MARK: - Identifier
    
    static let identifier = "MovieTableViewCell"
    
    // MARK: - Component
    
    private let numberingLabel: UILabel = {
        let label = UILabel()
        
        label.text = "10"
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAddView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    
    func setUI() {
        contentView.backgroundColor = .clear
    }
    
    // MARK: - Set AddView
    
    func setAddView() {
        [
            numberingLabel
        ].forEach(contentView.addSubview)
    }
    
    // MARK: - Set Constrains
    
    func setConstraints() {
        numberingLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(48)
        }
    }
}
