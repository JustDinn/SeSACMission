//
//  QueryData.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/29/25.
//

import Foundation

final class QueryData {
    static let shared = QueryData()
    
    var keyword = ""
    var sort = "sim"
    var pageNumber = 1
    var pageSize = 30
    var lastPage: Int?
    var searchedHistory: Set<String> = []
    
    private init() { }
    
    // 싱글톤 사용을 위한 억지(?) reset
    func reset() {
        keyword = ""
        sort = "sim"
        pageNumber = 1
        pageSize = 30
        lastPage = nil
    }
}
