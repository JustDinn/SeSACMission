//
//  BoxOfficeModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

struct MovieModel: Decodable {
    let movie: MovieResult
    
    enum CodingKeys: String, CodingKey {
        case movie = "boxOfficeResult"
    }
}

struct MovieResult: Decodable {
    let movieList: [MovieInfo]
    
    enum CodingKeys: String, CodingKey {
        case movieList = "dailyBoxOfficeList"
    }
}

struct MovieInfo: Decodable {
    let title: String
    let ranking: String
    let realeasedDate: String
    
    enum CodingKeys: String, CodingKey {
        case title = "movieNm"
        case ranking = "rank"
        case realeasedDate = "openDt"
    }
}
