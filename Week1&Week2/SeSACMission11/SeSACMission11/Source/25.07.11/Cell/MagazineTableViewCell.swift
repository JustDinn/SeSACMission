//
//  MagazineTableViewCell.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/11/25.
//

import UIKit
import Kingfisher

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
        magazineImageView.contentMode = .scaleAspectFill
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
    
    // MARK: - Configure Cell
    
    func configureCell(imageURL: String, title: String, subTitle: String, createdData: String) {
        let imageURL = URL(string: imageURL)
        
        magazineImageView.kf.setImage(with: imageURL)
        magazineTitleLabel.text = title
        magazineSubTitleLabel.text = subTitle
        magazineCreatedDateLabel.text = createdData
    }
}
