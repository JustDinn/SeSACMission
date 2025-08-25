//
//  BoxOfficeModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

struct BoxOfficeModel: Decodable {
    let boxOffice: BoxOfficeResult
    
    enum CodingKeys: String, CodingKey {
        case boxOffice = "boxOfficeResult"
    }
}

struct BoxOfficeResult: Decodable {
    let boxOfficeList: [BoxOfficeInfo]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeList = "dailyBoxOfficeList"
    }
}

struct BoxOfficeInfo: Decodable {
    let title: String
    let ranking: String
    let realeasedDate: String
    
    enum CodingKeys: String, CodingKey {
        case title = "movieNm"
        case ranking = "rank"
        case realeasedDate = "openDt"
    }
}
