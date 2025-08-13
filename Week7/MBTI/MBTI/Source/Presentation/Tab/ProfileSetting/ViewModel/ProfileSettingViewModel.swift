//
//  ProfileSettingViewModel.swift
//  MBTI
//
//  Created by HyoTaek on 8/13/25.
//

import Foundation

final class ProfileSettingViewModel {
    
    // MARK: - Property
    
    private var randomImageList: [String] = []
    
    // MARK: - Init
    
    init() {
        makeRandomImageList()
    }
    
    // MARK: - Method
    
    // 이미지 배열 생성
    private func makeRandomImageList() {
        for index in 1...12 {
            randomImageList.append("person\(index)")
        }
    }
}
