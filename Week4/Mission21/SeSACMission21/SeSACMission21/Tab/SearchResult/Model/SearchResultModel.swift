//
//  SearchResultModel.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import Foundation

struct Search: Decodable {
    let items: [SearchResultModel]
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
