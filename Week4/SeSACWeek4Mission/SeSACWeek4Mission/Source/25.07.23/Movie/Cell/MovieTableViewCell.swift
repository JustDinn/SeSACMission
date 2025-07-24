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
        
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        
        return label
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.textAlignment = .right
        
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
    
    // MARK: - Reuse Cell
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        numberingLabel.text = nil
        movieTitleLabel.text = nil
        releaseDateLabel.text = nil
    }
    
    // MARK: - Set UI
    
    func setUI() {
        contentView.backgroundColor = .clear
    }
    
    // MARK: - Set AddView
    
    func setAddView() {
        [
            numberingLabel,
            movieTitleLabel,
            releaseDateLabel
        ].forEach(contentView.addSubview)
    }
    
    // MARK: - Set Constrains
    
    func setConstraints() {
        numberingLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.leading.equalToSuperview()
            $0.width.equalTo(48)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(numberingLabel.snp.trailing).offset(16)
        }
        
        releaseDateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(movieTitleLabel.snp.trailing).offset(16)
        }
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with boxOfficeInfo: MovieInfo) {
        numberingLabel.text = "\(boxOfficeInfo.ranking)"
        movieTitleLabel.text = boxOfficeInfo.title
        releaseDateLabel.text = boxOfficeInfo.realeasedDate
    }
}
