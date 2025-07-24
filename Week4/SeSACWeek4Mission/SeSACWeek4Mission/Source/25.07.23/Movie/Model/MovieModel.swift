//
//  MovieModel.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/24/25.
//

import Foundation

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
