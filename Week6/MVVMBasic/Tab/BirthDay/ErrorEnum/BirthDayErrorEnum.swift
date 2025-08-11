//
//  BirthDayErrorEnum.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/9/25.
//

import Foundation

enum DateError: Error {
    case isEmptyYear
    case notIntYear
    case outOfYear
    case isEmptyMonth
    case notIntMonth
    case outOfMonth
    case isEmptyDate
    case notIntDate
    case outOfDate
}
