//
//  BMIErrorEnum.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/11/25.
//

import Foundation

enum BMIValidError: Error {
    case isHeightEmpty
    case isWeightEmpty
    case isNotIntHeight
    case outOfHeight
    case isNotIntWeight
    case outOfWeight
    case unknownError
}
