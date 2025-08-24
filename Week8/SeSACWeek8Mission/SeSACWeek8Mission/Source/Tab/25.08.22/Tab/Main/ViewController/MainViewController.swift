//
//  MainViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/25/25.
//

import UIKit
import SnapKit
import Then

final class MainViewController: UIViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        setProfileNaviBar("대장님의 다마고치")
    }
}
