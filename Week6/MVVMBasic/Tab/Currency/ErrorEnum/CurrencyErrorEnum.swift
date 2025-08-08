//
//  CurrencyErrorEnum.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/8/25.
//

import Foundation

enum CurrencyErrorEnum: Error {
    case isEmpty
    case isNotInt
    case isNegativeInt
    case unknownError
}
