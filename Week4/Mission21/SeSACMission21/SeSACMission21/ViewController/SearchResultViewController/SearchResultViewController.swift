//
//  SearchResultViewController.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import UIKit

final class SearchResultViewController: UIViewController {

    // MARK: - Properties
    
    private let keyword: String
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(keyword: String) {
        self.keyword = keyword
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
