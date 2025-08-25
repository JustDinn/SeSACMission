//
//  TabBarController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Component
    
    private let tamagotchiTab = UITabBarItem().then {
        $0.title = "다마고치"
    }
    
    private let lottoTab = UITabBarItem().then {
        $0.title = "로또"
    }
    
    private let boxOfficeTab = UITabBarItem().then {
        $0.title = "박스오피스"
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
}

extension TabBarController {
    
    // MARK: - Set TabBar
    
    private func setTabBar() {
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .systemGray3
        
        let tamagotchiVC = MainViewController()
        let tamagotchiNavigationVC = UINavigationController(rootViewController: tamagotchiVC)
        
        let lottoVC = LottoViewController()
        let lottoNavigationVC = UINavigationController(rootViewController: lottoVC)
        
        let boxOfficeVC = BoxOfficeViewController()
        let boxOfficeNavigationVC = UINavigationController(rootViewController: boxOfficeVC)
        
        viewControllers = [
            tamagotchiNavigationVC,
            lottoNavigationVC,
            boxOfficeNavigationVC
        ]
        
        tamagotchiNavigationVC.tabBarItem = tamagotchiTab
        lottoNavigationVC.tabBarItem = lottoTab
        boxOfficeNavigationVC.tabBarItem = boxOfficeTab
    }
}
