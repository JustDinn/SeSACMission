//
//  TravelTalkTableViewCell.swift
//  SeSACWeek3Mission
//
//  Created by HyoTaek on 7/21/25.
//

import UIKit

final class TravelTalkTableViewCell: UITableViewCell {

    // MARK: Identifier
    
    static let identifier = "TravelTalkTableViewCell"
    
    // MARK: - Component
    
    @IBOutlet private var chatRoomProfileImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setProfileImageView()
    }
    
    // MARK: - 프로필 사진 설정
    
    private func setProfileImageView() {
        let profileImageHeight = chatRoomProfileImageView.frame.height
        
        chatRoomProfileImageView.layer.cornerRadius = profileImageHeight / 2
    }
}
