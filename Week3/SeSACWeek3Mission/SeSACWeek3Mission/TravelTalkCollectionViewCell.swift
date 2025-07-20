//
//  TravelTalkCollectionViewCell.swift
//  SeSACWeek3Mission
//
//  Created by HyoTaek on 7/20/25.
//

import UIKit

final class TravelTalkCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    
    static let identifier = "TravelTalkCollectionViewCell"
    
    // MARK: - Components
    
    @IBOutlet private var profileImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setProfileImageView()
    }

    // MARK: - 프로필 이미지뷰 설정
    
    private func setProfileImageView() {
        let profileImageViewHeight = profileImageView.frame.height
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageViewHeight / 2
    }
}
