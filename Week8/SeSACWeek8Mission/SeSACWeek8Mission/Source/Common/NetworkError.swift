//
//  NetworkError.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case unAuthorized
    case notFound
    case serverError
    case networkDisconnected
    case unknownError
}
