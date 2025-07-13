//
//  TravelInfoTableViewCell.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/14/25.
//

import UIKit
import Cosmos

class TravelInfoTableViewCell: UITableViewCell {

    // MARK: - Components
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var ratingView: CosmosView!
    
    // MARK: - Life Cyle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabel()
        setRatingView()
    }
    
    // MARK: Set Label
    
    func setLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        subTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        subTitleLabel.textColor = .gray
    }
    
    // MARK: - Set RatingView
    
    func setRatingView() {
        ratingView.settings.updateOnTouch = false
        ratingView.settings.fillMode = .precise
        ratingView.settings.starSize = 18
        ratingView.settings.starMargin = 0
        ratingView.settings.filledColor = .systemYellow
        ratingView.settings.emptyBorderColor = .clear
        ratingView.settings.filledBorderColor = .clear
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with travelInfo: Travel) {
        titleLabel.text = travelInfo.title
        subTitleLabel.text = travelInfo.description
        
        if let rating = travelInfo.grade {
            ratingView.rating = rating
        } else {
            ratingView.isHidden = true
        }
    }
}
