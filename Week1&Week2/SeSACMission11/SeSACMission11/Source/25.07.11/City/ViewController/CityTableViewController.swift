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
    var filteredCities = CityInfo().city
    
    // MARK: - Components
    
    @IBOutlet var filterSegment: UISegmentedControl!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        filteredCities = cityInfos
    }
    
    // MARK: - Register Nib
    
    func registerNib() {
        let cityXib = UINib(nibName: CityTableViewCell.identifier, bundle: nil)
        
        tableView.register(cityXib, forCellReuseIdentifier: CityTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    
    // MARK: - Set Segment
    
    func setSegment() {
        
    }
    
    // MARK: - Action
    
    @IBAction func didSelectSegment(_ sender: UISegmentedControl) {
        filteredCities.removeAll()
        
        switch sender.selectedSegmentIndex {
        case 0:
            filteredCities = cityInfos
            
        case 1:
            filteredCities = cityInfos.filter { $0.domestic_travel }
            
        case 2:
            filteredCities = cityInfos.filter { !$0.domestic_travel }
            
        default:
            fatalError("잘못된 세그먼트 인덱스")
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
        let cellIndex = indexPath.row
        
        cell.configureCell(with: filteredCities[cellIndex])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
