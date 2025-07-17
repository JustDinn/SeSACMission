//
//  CityCollectionViewController.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/17/25.
//

import UIKit

class CityCollectionViewController: UIViewController {

    // MARK: - Properties
    
    let cityInfos = CityInfo().city
    var filteredCities = CityInfo().city
    
    // MARK: - Components
    
//    @IBOutlet var tableView: UITableView!
    @IBOutlet var filterSegment: UISegmentedControl!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredCities = cityInfos
        registerNib()
    }
    
    // MARK: - Register Nib
    
    func registerNib() {
        let cityXib = UINib(nibName: CityCollectionViewCell.identifier, bundle: nil)
        
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 64) / 2
        let height = width + 72
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .vertical
        
        collectionView.register(cityXib, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - 필터
    
    func filter() {
        didSelectSegment(filterSegment)
        
        if !searchTextField.text!.isEmpty {
            filterCities()
        }
    }
    
    // MARK: - 여행지 필터링
    
    func filterCities() {
        let searchingKeyword = searchTextField.text!.trimmingCharacters(in: .whitespaces).uppercased()
        
        filteredCities = filteredCities.filter {
            $0.city_name.contains(searchingKeyword) ||
            $0.city_english_name.contains(searchingKeyword) ||
            $0.city_explain.contains(searchingKeyword)
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
        
        collectionView.reloadData()
    }
    
    @IBAction func didEndEditingTextField(_ sender: UITextField) {
        filter()
        collectionView.reloadData()
    }
    
    @IBAction func didChangedTextField(_ sender: UITextField) {
        filter()
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView DataSource, Delegate

extension CityCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
        let cellIndex = indexPath.item
        
        cell.backgroundColor = .systemYellow
        cell.configureCell(with: filteredCities[cellIndex])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cityDetailVC = self.storyboard?.instantiateViewController(withIdentifier: CityDetailViewController.identifier) as! CityDetailViewController
        
        present(cityDetailVC, animated: true)
    }
}
