//
//  TravelTalkTableViewController.swift
//  SeSACWeek3Mission
//
//  Created by HyoTaek on 7/20/25.
//

import UIKit

final class TravelTalkTableViewController: UIViewController {
    
    // MARK: - Properties
    
    var chatRoomInfo: [Chat] = []
    
    // MARK: - Components
    
    @IBOutlet private var chatRoomTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    // MARK: - Set TableView
    
    private func setTableView() {
        let cell = UINib(nibName: "TravelTalkTableViewCell", bundle: nil)
        
        chatRoomTableView.register(cell, forCellReuseIdentifier: TravelTalkPartnerTableViewCell.identifier)
        chatRoomTableView.dataSource = self
        chatRoomTableView.delegate = self
        chatRoomTableView.separatorStyle = .none
    }
}

// MARK: - UITableView DataSource

extension TravelTalkTableViewController: UITableViewDataSource {
    
    // row 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoomInfo.count
    }
    
    // cell 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelTalkPartnerTableViewCell.identifier, for: indexPath) as! TravelTalkPartnerTableViewCell
        cell.configureCell(with: chatRoomInfo[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableView Delegate

extension TravelTalkTableViewController: UITableViewDelegate {
    
    // 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
