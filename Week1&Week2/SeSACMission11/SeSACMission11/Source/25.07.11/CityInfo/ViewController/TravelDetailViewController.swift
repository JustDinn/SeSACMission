//
//  TravelDetailViewController.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/15/25.
//

import UIKit
import Kingfisher

class TravelDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var travelDetailInfo: Travel?
    
    // MARK: - Components
    
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    // MARK: - Set UI
    
    func setUI() {
        if let travelInfo = travelDetailInfo,
           let imageURL = travelInfo.travel_image {
            imageView.kf.setImage(with: URL(string: imageURL))
        }
    }
}
