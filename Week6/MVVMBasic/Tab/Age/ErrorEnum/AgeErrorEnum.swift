//
//  AgeErrorEnum.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/9/25.
//

import Foundation

enum AgeValidError: Error {
    case empty
    case notInt
    case outOfRange
    case unknownError
}
