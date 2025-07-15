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
        
        setImageView()
        setUI()
    }
    
    // MARK: - Set UI
    
    func setUI() {
        if let travelInfo = travelDetailInfo,
           let imageURL = travelInfo.travel_image {
            imageView.kf.setImage(with: URL(string: imageURL))
        }
    }
    
    // MARK: - Set ImageView
    
    func setImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    }
}
