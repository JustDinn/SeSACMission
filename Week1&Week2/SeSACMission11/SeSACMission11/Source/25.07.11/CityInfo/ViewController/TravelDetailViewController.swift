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
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageView()
        setLabel()
        setUI()
    }
    
    // MARK: - Set UI
    
    func setUI() {
        if let travelInfo = travelDetailInfo {
            if let imageURL = travelInfo.travel_image {
                imageView.kf.setImage(with: URL(string: imageURL))
            }
            titleLabel.text = travelInfo.title
        }
    }
    
    // MARK: - Set ImageView
    
    func setImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    }
    
    // MARK: - Set Label
    
    func setLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
    }
}
