//
//  UIViewController++Extension.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/24/25.
//

import UIKit

extension UIViewController {
    
    // 영화 페이지로 이동
    func pushMovieVC() {
        let movieVC = MovieViewController()
        
        navigationController?.pushViewController(movieVC, animated: true)
    }
}
