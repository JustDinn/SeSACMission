//
//  AdTableViewCell.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/15/25.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    // MARK: - Components
    
    @IBOutlet var adTitleLabel: UILabel!
    @IBOutlet var adLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabel()
    }
    
    // MARK: - Set Label
    
    func setLabel() {
        adTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        adTitleLabel.numberOfLines = 2
        
        adLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        adLabel.backgroundColor = .white
        adLabel.layer.cornerRadius = 10
    }
}
