//
//  SettingTableViewController.swift
//  SesacWeek1Homework
//
//  Created by HyoTaek on 7/10/25.
//

import UIKit

class SettingTableViewController: UITableViewController {

    // MARK: - Properties
    
    let sectionHeaders = ["전체 설정", "개인 설정", "기타"]
//    let data = [
//        "전체 설정": ["공지사항", "실험실", "버전 정보"],
//        "개인 설정": ["개인/보안", "알림", "채팅", "멀티프로필"],
//        "기타": ["고객센터/도움말"]
//    ]
    let data = [
        ["공지사항", "실험실", "버전 정보"],
        ["개인/보안", "알림", "채팅", "멀티프로필"],
        ["고객센터/도움말"]
    ]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 4
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
}
