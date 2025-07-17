//
//  CityCollectionViewCell.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/17/25.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "CityCollectionViewCell"
    
    // MARK: - Components
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setImageView()
        setTitleLabel()
        setDescriptionLabel()
    }
    
    // MARK: - Set ImageView
    
    func setImageView() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.layer.cornerRadius = backgroundImageView.frame.width / 2
        backgroundImageView.clipsToBounds = true
    }
    
    // MARK: - Set TitleLabel
    
    func setTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
    }
    
    // MARK: - Set DescriptionLabel
    
    func setDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        descriptionLabel.textColor = .gray
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with cityInfo: City, searchingKeyword: String) {
        let titleText = "\(cityInfo.city_name) | \(cityInfo.city_english_name)"
        let titleAttributedString = NSMutableAttributedString(string: titleText)
        
        let descriptionText = cityInfo.city_explain
        let descriptionAttributedString = NSMutableAttributedString(string: descriptionText)
        
        let titleRange = (titleText as NSString).range(of: searchingKeyword)
        let descriptionRange = (descriptionText as NSString).range(of: searchingKeyword)
        
        titleAttributedString.addAttribute(.backgroundColor, value: UIColor.systemYellow, range: titleRange)
        descriptionAttributedString.addAttribute(.backgroundColor, value: UIColor.systemYellow, range: descriptionRange)
        
        backgroundImageView.kf.setImage(with: URL(string: cityInfo.city_image))
        titleLabel.attributedText = titleAttributedString
        descriptionLabel.attributedText = descriptionAttributedString
    }
}
