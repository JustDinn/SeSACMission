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
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var popVCButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageView()
        setLabel()
        setButton()
        setUI()
    }
    
    // MARK: - Set UI
    
    func setUI() {
        if let travelInfo = travelDetailInfo {
            if let imageURL = travelInfo.travel_image {
                imageView.kf.setImage(with: URL(string: imageURL))
            }
            titleLabel.text = travelInfo.title
            subTitleLabel.text = travelInfo.description
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
        titleLabel.numberOfLines = 0
        
        subTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
    }
    
    // MARK: - Set PopButton
    
    func setButton() {
        popVCButton.backgroundColor = .systemBlue
        popVCButton.layer.cornerRadius = 15
        popVCButton.layer.masksToBounds = true
        popVCButton.setTitle("다른 관광지 보러 가기", for: .normal)
        popVCButton.setTitleColor(.white, for: .normal)
    }
    
    // MARK: - Action
    
    @IBAction func didTapPopButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
