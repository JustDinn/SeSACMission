//
//  TravelInfoTableViewCell.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/14/25.
//

import UIKit
import Cosmos
import Kingfisher

class TravelInfoTableViewCell: UITableViewCell {

    // MARK: - Components
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var ratingView: CosmosView!
    @IBOutlet var savedCountLabel: UILabel!
    @IBOutlet var extraInfoStackView: UIStackView!
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var adLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    let numberFormatter = NumberFormatter()
    
    // MARK: - Life Cyle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabel()
        setAdLabel()
        setStackView()
        setRatingView()
        setImageView()
        setLikeButton()
        numberFormatter.numberStyle = .decimal
        
        contentView.bringSubviewToFront(likeButton)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.backgroundColor = .white
        
        titleLabel.text = ""
        subTitleLabel.text = ""
        savedCountLabel.text = ""
        
        ratingView.rating = 0.0
        travelImageView.image = nil
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
        extraInfoStackView.isHidden = false
        travelImageView.isHidden = false
        adLabel.isHidden = false
        likeButton.isHidden = false
    }
    
    // MARK: Set Label
    
    func setLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        subTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        subTitleLabel.textColor = .gray
        subTitleLabel.numberOfLines = 0
        savedCountLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        savedCountLabel.textColor = .gray
    }
    
    func setAdLabel() {
        adLabel.text = "AD"
        adLabel.isHidden = true
    }
    
    // MARK: - Set StackView
    
    func setStackView() {
        extraInfoStackView.alignment = .center
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
    
    // MARK: - Set Travel ImageView
    
    func setImageView() {
        travelImageView.layer.cornerRadius = 10
        travelImageView.contentMode = .scaleAspectFill
    }
    
    // MARK: - Set Like Button
    
    func setLikeButton() {
        likeButton.setTitle("", for: .normal)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .systemRed
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with travelInfo: Travel) {
        titleLabel.text = travelInfo.title
        subTitleLabel.text = travelInfo.description
        
        if let rating = travelInfo.grade,
           let savedCount = travelInfo.save,
           let travelImage = travelInfo.travel_image,
           let isLiked = travelInfo.like {
            ratingView.rating = rating
            
            if let formattedNumber = numberFormatter.string(from: NSNumber(value: savedCount)) {
                savedCountLabel.text = "저장 \(formattedNumber)"
            } else {
                savedCountLabel.text = "저장 \(savedCount)"
            }
            
            travelImageView.kf.setImage(with: URL(string: travelImage))
            
            isLiked
                ? likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                : likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            extraInfoStackView.isHidden = true
            travelImageView.isHidden = true
            likeButton.isHidden = true
        }
        
        adLabel.isHidden = !travelInfo.ad
    }
}
