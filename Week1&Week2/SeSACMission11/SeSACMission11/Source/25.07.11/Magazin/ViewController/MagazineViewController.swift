//
//  MagazineViewController.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/16/25.
//

import UIKit

class MagazineViewController: UIViewController {

    // MARK: - Properties
    
    let magazineList = MagazineInfo().magazine
    
    // MARK: - Components
    
    @IBOutlet var magazineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    // MARK: - Set TableView
    
    func setTableView() {
        let magazineXib = UINib(nibName: "MagazineTableViewCell", bundle: nil)
        
        magazineTableView.register(magazineXib, forCellReuseIdentifier: MagazineTableViewCell.identifier)
        magazineTableView.dataSource = self
        magazineTableView.delegate = self
    }
}

// MARK: - UITableView DataSource

extension MagazineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.identifier, for: indexPath) as! MagazineTableViewCell
        let magazineData = magazineList[indexPath.row]
        
        cell.configureCell(
            imageURL: magazineData.imageURL,
            title: magazineData.title,
            subTitle: magazineData.subTitle,
            createdData: magazineData.createdDate
        )
        
        return cell
    }
}

// MARK: - UITableView Delegate

extension MagazineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
}
