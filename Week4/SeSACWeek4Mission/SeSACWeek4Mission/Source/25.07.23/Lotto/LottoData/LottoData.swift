//
//  LottoData.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/24/25.
//

import UIKit

struct Lotto {
    var number: String
    let backgroundColor: UIColor
    var textColor: UIColor
    
    init(number: String = "", color: UIColor, textColor: UIColor = .white) {
        self.number = number
        self.backgroundColor = color
        self.textColor = textColor
    }
}

struct LottoData {
    
    private static var initialLottoRound: [Int] = []
    
    static var lottoRound: [Int] {
        for i in 1..<1182 {
            initialLottoRound.append(i)
        }
        return initialLottoRound
    }
    
    static var lottoNumbers: [Lotto] = [
        Lotto(color: .systemYellow),
        Lotto(color: .systemCyan),
        Lotto(color: .systemCyan),
        Lotto(color: .systemPink),
        Lotto(color: .systemPink),
        Lotto(color: .lightGray),
        Lotto(number: "+", color: .white, textColor: .black),
        Lotto(color: .lightGray)
    ]
    
    static var latestLotteryRound = 1181
    
    static var lottoRequestURL: String {
        return "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(LottoData.latestLotteryRound)"
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
