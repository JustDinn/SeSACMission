//
//  TravelTalkTableViewCell.swift
//  SeSACWeek3Mission
//
//  Created by HyoTaek on 7/21/25.
//

import UIKit

final class TravelTalkPartnerTableViewCell: UITableViewCell {

    // MARK: Identifier
    
    static let identifier = "TravelTalkPartnerTableViewCell"
    
    // MARK: - Component
    
    @IBOutlet private var chatRoomProfileImageView: UIImageView!
    @IBOutlet private var partnerNameLabel: UILabel!
    @IBOutlet private var partnerChattingLabel: UILabel!
    @IBOutlet private var messageTimeLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setProfileImageView()
        setPartnerNameLabel()
        setPartnerChattingLabel()
        setPartnerMessageTimeLabel()
    }
    
    // MARK: - 프로필 사진 설정
    
    private func setProfileImageView() {
        let profileImageHeight = chatRoomProfileImageView.frame.height
        
        chatRoomProfileImageView.layer.cornerRadius = profileImageHeight / 2
    }
    
    // MARK: - 파트너 이름 레이블 설정
    
    private func setPartnerNameLabel() {
        partnerNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    // MARK: - 파트너 채팅 레이블 설정
    
    private func setPartnerChattingLabel() {
        partnerChattingLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        partnerChattingLabel.numberOfLines = 0
        partnerChattingLabel.layer.borderColor = UIColor.gray.cgColor
        partnerChattingLabel.layer.borderWidth = 1
        partnerChattingLabel.layer.cornerRadius = 10
    }
    
    // MARK: - 파트너 채팅 시간 레이블 설정
    
    private func setPartnerMessageTimeLabel() {
        messageTimeLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        messageTimeLabel.textColor = .gray
        messageTimeLabel.textAlignment = .right
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with userChatInfo: Chat) {
        chatRoomProfileImageView.image = UIImage(named: userChatInfo.user.image)
        partnerNameLabel.text = userChatInfo.user.name
        partnerChattingLabel.text = userChatInfo.message
        messageTimeLabel.text = userChatInfo.date.convertDateFormat(toFormat: "HH:mm a")
    }
}
