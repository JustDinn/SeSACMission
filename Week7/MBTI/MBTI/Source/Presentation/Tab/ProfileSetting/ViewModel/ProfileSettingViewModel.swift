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
    private let mbtiList = ["E", "S", "T", "J", "I", "N", "F", "P"]
    
    // MARK: - Observable
    
    // Output
    struct Output {
        var randomImage: Observable<String> = Observable("")
        var mbtiList: Observable<[String]> = Observable([])
    }
    var output = Output()
    
    // MARK: - Init
    
    init() {
        makeRandomImageList()
        output.randomImage.value = randomImage()
        output.mbtiList.value = mbtiList
    }
    
    // MARK: - Method
    
    // 이미지 배열 생성
    private func makeRandomImageList() {
        for index in 1...12 {
            randomImageList.append("person\(index)")
        }
    }
    
    // 랜덤 이미지 생성
    private func randomImage() -> String {
        return randomImageList.randomElement() ?? "person1"
    }
}
