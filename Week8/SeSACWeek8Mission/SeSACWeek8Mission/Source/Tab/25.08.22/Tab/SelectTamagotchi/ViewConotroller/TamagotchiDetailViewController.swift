//
//  TamagotchiDetailViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/25/25.
//

import UIKit
import SnapKit
import Then

final class TamagotchiDetailViewController: UIViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
}
