//
//  TravelTalkTableViewController.swift
//  SeSACWeek3Mission
//
//  Created by HyoTaek on 7/20/25.
//

import UIKit

final class TravelTalkTableViewController: UIViewController {
    
    // MARK: - Properties
    
    var chatRoomInfo: [[Chat]] = []
    
    // MARK: - Components
    
    @IBOutlet private var chatRoomTableView: UITableView!
    @IBOutlet private var chattingTextField: UITextField!
    @IBOutlet private var sendButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setChattingTextField()
        setSendButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scrollToBottom()
    }
    
    // MARK: - Set TableView
    
    private func setTableView() {
        let partnerCell = UINib(nibName: "TravelTalkTableViewCell", bundle: nil)
        let myCell = UINib(nibName: "MyTravelTalkTableViewCell", bundle: nil)
        
        chatRoomTableView.register(partnerCell, forCellReuseIdentifier: TravelTalkPartnerTableViewCell.identifier)
        chatRoomTableView.register(myCell, forCellReuseIdentifier: MyTravelTalkTableViewCell.identifier)
        chatRoomTableView.dataSource = self
        chatRoomTableView.delegate = self
        chatRoomTableView.separatorStyle = .none
    }
    
    // MARK: - Set Chatting TextField
    
    private func setChattingTextField() {
        chattingTextField.backgroundColor = .systemGroupedBackground
        chattingTextField.layer.cornerRadius = 8
        chattingTextField.placeholder = "메시지를 입력하세요"
    }
    
    // MARK: - Set Send Button
    
    private func setSendButton() {
        sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        sendButton.tintColor = .gray
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
    
    // MARK: - collectionView 스크롤
    
    private func scrollToBottom() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let section = self.chatRoomInfo.count - 1
            let row = self.chatRoomInfo[self.chatRoomInfo.count - 1].count - 1
            
            self.chatRoomTableView.scrollToRow(at: IndexPath(row: row, section: section), at: .bottom, animated: false)
        }
    }
    
    // MARK: - Action
    
    @objc private func didTapSendButton() {
        let now = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        
        let convertNowStr = dateFormatter.string(from: now)
        let nowMyChattingMessage = chattingTextField.text!
        let nowChatting = Chat(user: ChatList.me, date: convertNowStr, message: nowMyChattingMessage)
        
        for (index, section) in chatRoomInfo.enumerated() {
            // 기존 채팅 날짜중에 현재 채팅의 날짜가 있을 경우
            if section[0].date.prefix(10) == convertNowStr.prefix(10) {
                chatRoomInfo[index].append(nowChatting)
            }
            // 마지막까지 검사했지만 기존 채팅 날짜와 현재 채팅 날짜가 겹치지 않을 경우
            else if index == chatRoomInfo.count - 1 {
                // 기존 채팅의 날짜에 현재 채팅의 날짜가 없는 경우 새로운 날짜 섹션을 생성
                chatRoomInfo.append([nowChatting])
            }
        }
        
        chattingTextField.text = nil
        chatRoomTableView.reloadData()
        scrollToBottom()
    }
}

// MARK: - UITableView DataSource

extension TravelTalkTableViewController: UITableViewDataSource {
    
    // section 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return chatRoomInfo.count
    }
    
    // row 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoomInfo[section].count
    }
    
    // cell 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if chatRoomInfo[section][row].user.name == "김새싹" {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyTravelTalkTableViewCell.identifier, for: indexPath) as! MyTravelTalkTableViewCell
            cell.configureCell(with: chatRoomInfo[section][row])
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelTalkPartnerTableViewCell.identifier, for: indexPath) as! TravelTalkPartnerTableViewCell
            cell.configureCell(with: chatRoomInfo[section][row])
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    // section 헤더 타이틀
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "============ \(chatRoomInfo[section][0].date.prefix(10)) ============"
    }
}

// MARK: - UITableView Delegate

extension TravelTalkTableViewController: UITableViewDelegate {
    
    // 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
