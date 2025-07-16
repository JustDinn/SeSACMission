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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Configure
    
    func configure() {
        cityImageView.kf.setImage(with: URL(string: cityInfo?.city_image ?? ""))
    }
}
