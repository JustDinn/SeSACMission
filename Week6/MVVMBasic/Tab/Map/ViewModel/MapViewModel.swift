//
//  MapViewModel.swift
//  MVVMBasic
//
//  Created by HyoTaek on 8/12/25.
//

import Foundation

final class MapViewModel {
    
    // MARK: - Property
    
    private let restaurantList = RestaurantList.restaurantArray
    
    // MARK: - Observable
    
    var input = Observable("")
    var output = Observable([Restaurant]())
    
    // MARK: - Init
    
    init() {
        input.value = "전체보기"
        
        input.bind { category in
            if category == "전체보기" {
                self.output.value = self.restaurantList
            } else {
                self.output.value = self.restaurantList.filter { $0.category == category }
            }
        }
    }
}
