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
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let section = self.chatRoomInfo.count - 1
            let row = self.chatRoomInfo[self.chatRoomInfo.count - 1].count - 1
            
            DispatchQueue.main.async {
                self.chatRoomTableView.scrollToRow(at: IndexPath(row: row, section: section), at: .bottom, animated: false)
            }
        }
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
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelTalkPartnerTableViewCell.identifier, for: indexPath) as! TravelTalkPartnerTableViewCell
            cell.configureCell(with: chatRoomInfo[section][row])
            
            return cell
        }
    }
}

// MARK: - UITableView Delegate

extension TravelTalkTableViewController: UITableViewDelegate {
    
    // 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
