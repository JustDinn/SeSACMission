//
//  TravelInfoTableViewCell.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/14/25.
//

import UIKit

class TravelInfoTableViewCell: UITableViewCell {

    // MARK: - Components
    
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: - Life Cyle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabel()
    }
    
    // MARK: Set Label
    
    func setLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with travelInfo: Travel) {
        titleLabel.text = travelInfo.title
    }
}
