//
//  TamagotchiViewModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa

final class TamagotchiViewModel {
    
    // MARK: - Input
    
    struct Input {
        
    }
    
    // MARK: - Output
    
    struct Output {
        let tamagotchiList: BehaviorSubject<[TamagotchiModel]>
    }
    
    // MARK: - Transform
    
    func transform() -> Output {
        let tamagotchiList = BehaviorSubject<[TamagotchiModel]>(value: TamagotchiModel.tamagotchies)
        
        return Output(tamagotchiList: tamagotchiList)
    }
}
