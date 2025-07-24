//
//  LottoModel.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/24/25.
//

import Foundation

struct LottoModel: Decodable {
    let drawnDate: String
    let drawnRound: Int
    let lottoNumber1: Int
    let lottoNumber2: Int
    let lottoNumber3: Int
    let lottoNumber4: Int
    let lottoNumber5: Int
    let lottoNumber6: Int
    let lottoBonusNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case drawnDate = "drwNoDate"
        case drawnRound = "drwNo"
        case lottoNumber1 = "drwtNo1"
        case lottoNumber2 = "drwtNo2"
        case lottoNumber3 = "drwtNo3"
        case lottoNumber4 = "drwtNo4"
        case lottoNumber5 = "drwtNo5"
        case lottoNumber6 = "drwtNo6"
        case lottoBonusNumber = "bnusNo"
    }
}
