//
//  TravelInfoTableViewController.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/13/25.
//

import UIKit

class TravelInfoTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let travelInfo = TravelInfo().travel

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - UITableview DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelInfoCell", for: indexPath) as! TravelInfoTableViewCell
        if travelInfo[indexPath.row].ad {
            cell.backgroundColor = .systemGreen
        }
        cell.configureCell(with: travelInfo[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
