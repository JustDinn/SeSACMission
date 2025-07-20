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
    @IBOutlet private var lastChatLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setProfileImageView()
        setNameLabel()
        setLastChatLabel()
        setDateLabel()
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
    
    // MARK: - 마지막 채팅 레이블 설정
    
    private func setLastChatLabel() {
        lastChatLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lastChatLabel.textColor = .gray
    }
    
    // MARK: - 날짜 레이블 설정
    
    private func setDateLabel() {
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with chatingRoomInfo: ChatRoom) {
        let chatingLastIndex = chatingRoomInfo.chatList.count - 1
        
        profileImageView.image = UIImage(named: chatingRoomInfo.chatroomImage)
        nameLabel.text = chatingRoomInfo.chatroomName
        lastChatLabel.text = chatingRoomInfo.chatList[chatingLastIndex].message
        dateLabel.text = chatingRoomInfo.chatList[chatingLastIndex].date.convertDateFormat()
    }
}
