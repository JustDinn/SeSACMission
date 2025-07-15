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
    @IBOutlet var backButton: UIBarButtonItem!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackButton()
        setLabel()
        setAdUI()
    }
    
    // MARK: - Set UI
    
    func setAdUI() {
        if let ad = adInfo {
            adTitleLabel.text = ad.title
        }
    }
    
    // MARK: - Set Back Button
    
    func setBackButton() {
        backButton.image = UIImage(systemName: "xmark")
        backButton.tintColor = .black
    }
    
    // MARK: - Set Label
    
    func setLabel() {
        adTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .black)
        adTitleLabel.textAlignment = .center
        adTitleLabel.numberOfLines = 0
    }
}
