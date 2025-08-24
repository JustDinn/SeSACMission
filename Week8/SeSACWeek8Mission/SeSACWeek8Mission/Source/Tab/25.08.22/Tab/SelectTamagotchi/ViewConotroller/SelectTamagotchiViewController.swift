//
//  SelectTamagotchiViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/24/25.
//

import UIKit
import SnapKit
import Then

final class SelectTamagotchiViewController: UIViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        view.backgroundColor = .main
        setBackNaviBar("다마고치 변경하기")
    }
}
