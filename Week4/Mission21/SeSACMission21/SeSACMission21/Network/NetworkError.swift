//
//  NetworkError.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/30/25.
//

import Foundation

enum NetworkError: Error {
    case responseFail(statusCode: Int)
    case decodingFailed
    case unknownError
}
