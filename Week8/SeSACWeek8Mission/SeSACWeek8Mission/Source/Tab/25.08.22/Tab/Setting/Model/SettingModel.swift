//
//  SettingModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/23/25.
//

import Foundation

struct SettingModel {
    let icon: String
    let title: String
    let nickname: String
    
    static let settingData: [SettingModel] = [
        SettingModel(
            icon: "pencil",
            title: "내 이름 설정하기",
            nickname: ""
        ),
        SettingModel(
            icon: "moon.fill",
            title: "다마고치 변경하기",
            nickname: ""
        ),
        SettingModel(
            icon: "arrow.clockwise",
            title: "데이터 초기화",
            nickname: ""
        )
    ]
}
