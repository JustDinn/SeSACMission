//
//  LottoModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

struct LottoModel: Decodable {
    let first: Int
    let second: Int
    let third: Int
    let fourth: Int
    let fifth: Int
    let sixth: Int
    let bonus: Int
    
    enum CodingKeys: String, CodingKey {
        case first = "drwtNo1"
        case second = "drwtNo2"
        case third = "drwtNo3"
        case fourth = "drwtNo4"
        case fifth = "drwtNo5"
        case sixth = "drwtNo6"
        case bonus = "bnusNo"
    }
}
