//
//  TravelMagazineTableViewController.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/11/25.
//

import UIKit

final class TravelMagazineTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension TravelMagazineTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "magazineCell", for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
}
