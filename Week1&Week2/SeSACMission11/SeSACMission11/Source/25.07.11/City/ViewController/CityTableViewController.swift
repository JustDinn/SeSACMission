//
//  CityTableViewController.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/15/25.
//

import UIKit

class CityTableViewController: UITableViewController {

    // MARK: - Properties
    
    let cityInfos = CityInfo().city
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
    }
    
    // MARK: - Register Nib
    
    func registerNib() {
        let cityXib = UINib(nibName: CityTableViewCell.identifier, bundle: nil)
        
        tableView.register(cityXib, forCellReuseIdentifier: CityTableViewCell.identifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityInfos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
