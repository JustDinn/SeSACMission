//
//  QueryData.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/29/25.
//

import Foundation

final class QueryData {
    static let shared = QueryData()
    
    var keyword: String?
    var sort = "sim"
    var pageNumber = 1
    var pageSize = 30
    
    private init() { }
}
