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
    
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setImageView()
    }
    
    // MARK: - Set ImageView
    
    func setImageView() {
        magazineImageView.image = UIImage(systemName: "star")
        magazineImageView.layer.cornerRadius = 10
    }
}
