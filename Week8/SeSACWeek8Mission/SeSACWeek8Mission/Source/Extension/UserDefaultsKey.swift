//
//  UserDefaultsKey.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/23/25.
//

import Foundation

enum UserDefaultsKey {
    case nickname
    case tamagotchiName
    case tamagotchiImage
    case level
    
    var value: String {
        switch self {
        case .nickname:
            return "NICKNAME"
        case .tamagotchiName:
            return "TAMAGOTCHI_NAME"
        case .tamagotchiImage:
            return "TAMAGOTCHI_IMAGE"
        case .level:
            return "LEVEL"
        }
    }
}
