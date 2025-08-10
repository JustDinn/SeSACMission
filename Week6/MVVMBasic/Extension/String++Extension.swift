//
//  String++Extension.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/7/25.
//

import Foundation

extension String {
    
    func toDate(format: String = "yyyy.MM.dd") -> Date? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: self)
    }
}
