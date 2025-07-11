//
//  MagazineTableViewCell.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/11/25.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {

    // MARK: - Components
    
    @IBOutlet var magazineImageView: UIImageView!
    @IBOutlet var magazineTitleLabel: UILabel!
    @IBOutlet var magazineSubTitleLabel: UILabel!
    @IBOutlet var magazineCreatedDateLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setImageView()
        setLabel()
    }
    
    // MARK: - Set ImageView
    
    func setImageView() {
        magazineImageView.image = UIImage(systemName: "star")
        magazineImageView.layer.cornerRadius = 10
    }
    
    // MARK: - Set Label
    
    func setLabel() {
        [
            magazineTitleLabel,
            magazineSubTitleLabel,
            magazineCreatedDateLabel
        ].forEach {
            $0?.numberOfLines = 0
        }
    }
}
