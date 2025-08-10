//
//  BirthDayErrorEnum.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/9/25.
//

import Foundation

enum DateError: Error {
    case notIntYear
    case outOfYear
    case notIntMonth
    case outOfMonth
    case notIntDate
    case outOfDate
    case unknownError
}
