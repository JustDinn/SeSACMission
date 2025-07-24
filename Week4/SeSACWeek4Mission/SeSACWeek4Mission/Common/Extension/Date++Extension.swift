//
//  Date++Extension.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/25/25.
//

import Foundation

extension Date {
    
    // 시간 부분 버리기
    var onlyDate: Date {
        let component = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return Calendar.current.date(from: component) ?? Date()
    }
}
