//
//  TravelInfoTableViewController.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/13/25.
//

import UIKit
import Toast

class TravelInfoTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var travelInfo = TravelInfo().travel
    var backgroundColors: [UIColor] = [.systemYellow, .systemGreen, .systemOrange]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let travelInfoXib = UINib(nibName: "TravelInfoTableViewCell", bundle: nil)
        let adXib = UINib(nibName: "AdTableViewCell", bundle: nil)
        
        tableView.register(travelInfoXib, forCellReuseIdentifier: "TravelInfoTableViewCell")
        tableView.register(adXib, forCellReuseIdentifier: "AdTableViewCell")
    }
    
    // MARK: - Action

    @IBAction func didTapLikeButton(_ sender: UIButton) {
        if let currentLike = travelInfo[sender.tag].like {
            let indexPath = IndexPath(row: sender.tag, section: 0)
            
            travelInfo[sender.tag].like = !currentLike
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    // MARK: - UITableview DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndex = indexPath.row
        
        if travelInfo[cellIndex].ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
            let randomColor = backgroundColors.randomElement()!
            
            cell.setCellBackgroundColor(backgroundColor: randomColor)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "travelInfoCell", for: indexPath) as! TravelInfoTableViewCell
            cell.configureCell(with: travelInfo[indexPath.row])
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellIndex = indexPath.row
        let currentY = tableView.contentOffset.y + tableView.frame.height * 0.75
        let centerX = tableView.frame.width / 2
        
        if travelInfo[cellIndex].ad {
            self.view.makeToast("광고 셀입니다", duration: 1.0, point: CGPoint(x: centerX, y: currentY), title: nil, image: nil) { _ in }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
