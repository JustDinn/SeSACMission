//
//  LottoData.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/24/25.
//

import Foundation

struct LottoData {
    
    private static var initialLottoRound: [String] = []
    
    static var lottoRound: [String] {
        for i in 1..<1182 {
            initialLottoRound.append(String(i))
        }
        return initialLottoRound
    }
}
