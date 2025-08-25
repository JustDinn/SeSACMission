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
    
    // MARK: - Property
    
    private let tamagotchiListSubject = BehaviorSubject<[TamagotchiModel]>(value: TamagotchiModel.tamagotchies)
    
    // MARK: - Input
    
    struct Input {
        
    }
    
    // MARK: - Output
    
    struct Output {
        let tamagotchiList: BehaviorSubject<[TamagotchiModel]>
    }
    
    // MARK: - Transform
    
    func transform() -> Output {
        return Output(tamagotchiList: tamagotchiListSubject)
    }
    
    // MARK: - 다마고치 이미지들 업데이트
    
    func updateTamagotchiList(_ tamagotchies: [TamagotchiModel]) {
        tamagotchiListSubject.onNext(tamagotchies)
    }
}
