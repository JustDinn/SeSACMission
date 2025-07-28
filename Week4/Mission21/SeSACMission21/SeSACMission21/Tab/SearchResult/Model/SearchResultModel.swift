//
//  SearchResultModel.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import Foundation

struct Search: Decodable {
    let totalCount: Int
    let items: [SearchResultModel]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total"
        case items
    }
}

struct SearchResultModel: Decodable {
    let itemImage: String
    let mallName: String
    let title: String
    let itemPrice: String
    
    enum CodingKeys: String, CodingKey {
        case itemImage = "image"
        case mallName
        case title
        case itemPrice = "lprice"
    }
}

struct Sort {
    let sort: String
    let title: String
    
    static let filters = [
        Sort(sort: "sim", title: "정확도"),
        Sort(sort: "date", title: "날짜순"),
        Sort(sort: "asc", title: "가격높은순"),
        Sort(sort: "dsc", title: "가격낮은순")
    ]
}
