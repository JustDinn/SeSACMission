//
//  SearchViewController.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import UIKit

final class SearchViewController: UIViewController, InitialSetProtocol {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Set UI
    
    func setUI() {
        view.backgroundColor = .white
    }
    
    // MARK: - Set Hierarchy
    
    func setHierarchy() {
        [
            
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    func setConstraints() {
        <#code#>
    }
}
