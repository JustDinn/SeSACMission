//
//  CityViewController.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/16/25.
//

import UIKit

class CityViewController: UIViewController {

    // MARK: - Properties
    
    let cityInfos = CityInfo().city
    var filteredCities = CityInfo().city
    
    // MARK: - Components
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var filterSegment: UISegmentedControl!
    @IBOutlet var searchTextField: UITextField!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredCities = cityInfos
        registerNib()
    }
    
    // MARK: - Register Nib
    
    func registerNib() {
        let cityXib = UINib(nibName: CityTableViewCell.identifier, bundle: nil)
        
        tableView.register(cityXib, forCellReuseIdentifier: CityTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    // MARK: - 필터
    
    func filter() {
        if searchTextField.text!.isEmpty {
            didSelectSegment(filterSegment)
        } else {
            didSelectSegment(filterSegment)
            filterCities()
        }
    }
    
    // MARK: - 여행지 필터링
    
    func filterCities() {
        filteredCities = filteredCities.filter {
            $0.city_name.contains(searchTextField.text!) ||
            $0.city_english_name.contains(searchTextField.text!) ||
            $0.city_explain.contains(searchTextField.text!)
        }
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
    
    @IBAction func didEndEditingTextField(_ sender: UITextField) {
        filter()
        tableView.reloadData()
    }
    
    @IBAction func didChangedTextField(_ sender: UITextField) {
        filter()
        tableView.reloadData()
    }
}

extension CityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
        let cellIndex = indexPath.row
        
        cell.configureCell(with: filteredCities[cellIndex])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
