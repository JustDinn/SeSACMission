//
//  TravelInfoViewController.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/16/25.
//

import UIKit
import Toast

class TravelInfoViewController: UIViewController {

    // MARK: - Properties
    
    var travelInfo = TravelInfo().travel
    var backgroundColors: [UIColor] = [.systemYellow, .systemGreen, .systemOrange]
    
    // MARK: - Components
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
    }
    
    // MARK: - Register Nib
    
    func registerNib() {
        let travelInfoXib = UINib(nibName: "TravelInfoTableViewCell", bundle: nil)
        let adXib = UINib(nibName: "AdTableViewCell", bundle: nil)
        
        tableView.register(travelInfoXib, forCellReuseIdentifier: TravelInfoTableViewCell.identifier)
        tableView.register(adXib, forCellReuseIdentifier: AdTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Action

    @IBAction func didTapLikeButton(_ sender: UIButton) {
        if let currentLike = travelInfo[sender.tag].like {
            let indexPath = IndexPath(row: sender.tag, section: 0)
            
            travelInfo[sender.tag].like = !currentLike
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}

extension TravelInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndex = indexPath.row
        
        if travelInfo[cellIndex].ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
            let randomColor = backgroundColors.randomElement()!
            
            cell.configureCell(with: travelInfo[cellIndex])
            cell.setCellBackgroundColor(backgroundColor: randomColor)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelInfoTableViewCell.identifier, for: indexPath) as! TravelInfoTableViewCell
            cell.configureCell(with: travelInfo[indexPath.row])
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellIndex = indexPath.row
        let currentY = tableView.contentOffset.y + tableView.frame.height * 0.75
        let centerX = tableView.frame.width / 2
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let travelDetailVC = storyboard.instantiateViewController(withIdentifier: "TravelDetailVC") as! TravelDetailViewController
        let travelAdVC = storyboard.instantiateViewController(withIdentifier: "TravelAdVC") as! TravelAdViewController
        
        if travelInfo[cellIndex].ad {
            travelAdVC.adInfo = travelInfo[cellIndex]
            travelAdVC.modalPresentationStyle = .fullScreen
            
            tableView.makeToast("광고 셀입니다", duration: 0.5, point: CGPoint(x: centerX, y: currentY), title: nil, image: nil) { _ in
                self.present(travelAdVC, animated: true)
            }
        } else {
            travelDetailVC.travelDetailInfo = travelInfo[cellIndex]
            navigationController?.pushViewController(travelDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
