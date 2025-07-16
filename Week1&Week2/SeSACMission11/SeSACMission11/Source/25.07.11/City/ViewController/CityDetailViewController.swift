//
//  CityDetailViewController.swift
//  SeSACMission11
//
//  Created by HyoTaek on 7/16/25.
//

import UIKit
import Kingfisher

class CityDetailViewController: UIViewController {

    // MARK: - Properties
    
    static let identifier = "CityDetailViewController"
    var cityInfo: City?
    
    // MARK: - Components
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityDescriptionLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Configure
    
    func configure() {
        if let cityInfo = cityInfo {
            cityImageView.kf.setImage(with: URL(string: cityInfo.city_image))
            cityNameLabel.text = "\(cityInfo.city_name) | \(cityInfo.city_english_name)"
            cityDescriptionLabel.text = cityInfo.city_explain
        }
    }
}
