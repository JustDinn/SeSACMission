//
//  LottoData.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/24/25.
//

import UIKit

struct Lotto {
    let number: String
    let backgroundColor: UIColor
    var textColor: UIColor
    
    init(number: String, color: UIColor, textColor: UIColor = .white) {
        self.number = number
        self.backgroundColor = color
        self.textColor = textColor
    }
}

struct LottoData {
    
    private static var initialLottoRound: [String] = []
    
    static var lottoRound: [String] {
        for i in 1..<1182 {
            initialLottoRound.append(String(i))
        }
        return initialLottoRound
    }
    
    static let lottoNumbers: [Lotto] = [
        Lotto(number: "6", color: .systemYellow),
        Lotto(number: "14", color: .systemCyan),
        Lotto(number: "16", color: .systemCyan),
        Lotto(number: "21", color: .systemPink),
        Lotto(number: "26", color: .systemPink),
        Lotto(number: "38", color: .lightGray),
        Lotto(number: "+", color: .white, textColor: .black),
        Lotto(number: "40", color: .lightGray)
    ]
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
