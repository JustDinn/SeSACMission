//
//  MyTravelTalkTableViewCell.swift
//  SeSACWeek3Mission
//
//  Created by HyoTaek on 7/21/25.
//

import UIKit

final class MyTravelTalkTableViewCell: UITableViewCell {

    // MARK: - Identifier
    
    static let identifier = "MyTravelTalkTableViewCell"
    
    // MARK: - Components
    
    @IBOutlet private var myMessageLabel: UILabel!
    @IBOutlet private var myMessageTimeLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setMyMessageLabel()
        setMyMessageTimeLabel()
    }
    
    // MARK: - 나의 메시지 레이블 설정
    
    private func setMyMessageLabel() {
        myMessageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        myMessageLabel.numberOfLines = 0
        myMessageLabel.layer.borderColor = UIColor.gray.cgColor
        myMessageLabel.layer.borderWidth = 1
        myMessageLabel.layer.cornerRadius = 10
        myMessageLabel.layer.masksToBounds = true
        myMessageLabel.backgroundColor = .systemGray5
        myMessageLabel.textAlignment = .right
    }
    
    // MARK: - 나의 메시지 시간 레이블 설정
    
    private func setMyMessageTimeLabel() {
        myMessageTimeLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        myMessageTimeLabel.textColor = .gray
        myMessageTimeLabel.textAlignment = .right
    }
    
    // MARK: - Configure Cell
    
    func configureCell(with userChatInfo: Chat) {
        myMessageLabel.text = userChatInfo.message
        myMessageTimeLabel.text = userChatInfo.date.convertDateFormat(toFormat: "HH:mm a")
    }
}
