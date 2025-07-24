//
//  Calendar++Extension.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/25/25.
//

import Foundation

extension Calendar {
    
    // 두 날짜 사이의 날짜 차이 구하기
    func getDateGap(from: Date, to: Date) -> Int {
        let fromDateOnly = from.onlyDate
        let toDateOnly = to.onlyDate
        return self.dateComponents([.day], from: fromDateOnly, to: toDateOnly).day ?? 0
    }
}
