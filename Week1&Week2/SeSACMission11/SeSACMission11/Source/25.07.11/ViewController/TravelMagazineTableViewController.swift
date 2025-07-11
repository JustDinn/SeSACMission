//
//  TravelMagazineTableViewController.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/11/25.
//

import UIKit

final class TravelMagazineTableViewController: UITableViewController {

    // MARK: - Properties
    
    let magazineList = MagazineInfo().magazine
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - UITableView DataSource

extension TravelMagazineTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "magazineCell", for: indexPath) as! MagazineTableViewCell
        let magazineData = magazineList[indexPath.row]
        
        cell.configureCell(
            title: magazineData.title,
            subTitle: magazineData.subTitle,
            createdData: magazineData.createdDate
        )
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
}
