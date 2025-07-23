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

struct NowDate {
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter
    }()
    
    static var today: String {
        return dateFormatter.string(from: Date())
    }
}
