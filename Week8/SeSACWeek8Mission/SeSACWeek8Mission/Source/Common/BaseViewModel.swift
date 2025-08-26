//
//  BaseViewModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

import Foundation

protocol BaseViewModel {
    
    associatedtype In
    associatedtype Out
    
    func transform(input: In) -> Out
}
