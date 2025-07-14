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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.backgroundColor = .white
        adTitleLabel.text = ""
    }
    
    // MARK: - Set Label
    
    func setLabel() {
        adTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        adTitleLabel.numberOfLines = 0
        adTitleLabel.textAlignment = .center
        
        adLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        adLabel.backgroundColor = .white
        adLabel.layer.cornerRadius = 5
        adLabel.layer.masksToBounds = true
        adLabel.text = "AD"
        adLabel.textAlignment = .center
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with travelInfo: Travel) {
        adTitleLabel.text = travelInfo.title
    }
}
