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
    @IBOutlet private var nameLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setProfileImageView()
        setNameLabel()
    }

    // MARK: - 프로필 이미지뷰 설정
    
    private func setProfileImageView() {
        let profileImageViewHeight = profileImageView.frame.height
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageViewHeight / 2
    }
    
    // MARK: - 이름 레이블 설정
    
    private func setNameLabel() {
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
}
