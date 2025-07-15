//
//  CityTableViewCell.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/15/25.
//

import UIKit
import Kingfisher

class CityTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "CityTableViewCell"
    
    // MARK: - Components
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var backgroundImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setContainerViewUI()
        setImageView()
    }
    
    // MARK: - Set ContainerView UI
    
    func setContainerViewUI() {
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        containerView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
    }
    
    // MARK: - Set ImageView
    
    func setImageView() {
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with cityInfo: City) {
        backgroundImageView.kf.setImage(with: URL(string: cityInfo.city_image))
    }
}
