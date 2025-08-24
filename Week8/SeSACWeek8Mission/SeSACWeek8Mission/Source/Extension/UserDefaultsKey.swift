//
//  UserDefaultsKey.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/23/25.
//

import Foundation

enum UserDefaultsKey {
    case nickname
    case tamagotchi
    
    var value: String {
        switch self {
        case .nickname:
            return "NICKNAME"
        case .tamagotchi:
            return "TAMAGOTCHI"
        }
    }
}
