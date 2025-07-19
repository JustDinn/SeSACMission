//
//  ViewController.swift
//  SeSACWeek3Mission
//
//  Created by HyoTaek on 7/20/25.
//

import UIKit

final class TravelTalkViewController: UIViewController {

    @IBOutlet private var searchBar: UISearchBar!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
    }
    
    // MARK: - 검색바 설정
    
    private func setSearchBar() {
        searchBar.placeholder = "친구 이름을 검색해보세요"
        searchBar.searchBarStyle = .minimal
    }
}
