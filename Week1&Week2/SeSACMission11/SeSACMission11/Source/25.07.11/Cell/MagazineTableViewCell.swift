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
        
        magazineTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        magazineSubTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        magazineSubTitleLabel.textColor = .gray
        magazineCreatedDateLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        magazineCreatedDateLabel.textColor = .gray
        magazineCreatedDateLabel.textAlignment = .right
    }
    
    // MARK: - Configure Cell
    
    func configureCell(imageURL: String, title: String, subTitle: String, createdData: String) {
        let imageURL = URL(string: imageURL)
        let dateFormatter = DateFormatter()
        
        magazineImageView.kf.setImage(with: imageURL)
        magazineTitleLabel.text = title
        magazineSubTitleLabel.text = subTitle
        
        dateFormatter.dateFormat = "yyMMdd"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")

        if let date = dateFormatter.date(from: createdData) {
            dateFormatter.dateFormat = "yy년 MM월 dd일"
            
            magazineCreatedDateLabel.text = dateFormatter.string(from: date)
        }
    }
}
