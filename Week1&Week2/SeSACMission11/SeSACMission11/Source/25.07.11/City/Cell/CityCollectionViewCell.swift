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
    }
    
    // MARK: - Set TitleLabel
    
    func setTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .black)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .right
    }
    
    // MARK: - Set DescriptionLabel
    
    func setDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        descriptionLabel.textColor = .white
        descriptionLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with cityInfo: City) {
        backgroundImageView.kf.setImage(with: URL(string: cityInfo.city_image))
        titleLabel.text = "\(cityInfo.city_name) | \(cityInfo.city_english_name)"
        descriptionLabel.text = cityInfo.city_explain
    }
}
