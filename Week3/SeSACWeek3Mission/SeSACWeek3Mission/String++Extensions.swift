//
//  String++Extensions.swift
//  SeSACWeek3Mission
//
//  Created by HyoTaek on 7/20/25.
//

import Foundation

extension String {
    
    func convertDateFormat(fromFormat: String = "yyyy-MM-dd HH:mm", toFormat: String = "yyyy.MM.dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = fromFormat
        
        // 변환 실패시 원본 문자열 반환
        guard let date = dateFormatter.date(from: self) else {
            return self
        }
        
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date)
    }
}
