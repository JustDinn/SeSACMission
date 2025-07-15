//
//  TravelAdViewController.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/15/25.
//

import UIKit

class TravelAdViewController: UIViewController {

    // MARK: - Properties
    
    var adInfo: Travel?
    
    // MARK: - Components
    
    @IBOutlet var adTitleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .black)
        adTitleLabel.textAlignment = .center
        adTitleLabel.numberOfLines = 0
        
        setAdUI()
    }
    
    // MARK: - Set UI
    
    func setAdUI() {
        if let ad = adInfo {
            adTitleLabel.text = ad.title
        }
    }
}
