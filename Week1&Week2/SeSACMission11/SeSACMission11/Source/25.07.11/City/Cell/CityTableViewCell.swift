//
//  CityTableViewCell.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/15/25.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "CityTableViewCell"
    
    // MARK: - Components
    
    @IBOutlet var containerView: UIView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setContainerViewUI()
    }
    
    // MARK: - Set ContainerView UI
    
    func setContainerViewUI() {
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        containerView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
    }
}
