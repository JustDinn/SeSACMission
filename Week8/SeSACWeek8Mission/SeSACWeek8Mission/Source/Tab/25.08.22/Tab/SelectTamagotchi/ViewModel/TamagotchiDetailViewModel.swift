//
//  TamagotchiDetailViewModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/25/25.
//

import Foundation
import RxSwift
import RxCocoa

final class TamagotchiDetailViewModel {
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Input

    struct Input {
        let cancelTapped: ControlEvent<Void>
        let selectTapped: PublishSubject<String>
    }
    
    // MARK: - Output
    
    struct Output {
        let dismiss: PublishSubject<Void>
        let select: PublishSubject<Void>
    }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let popVC = PublishSubject<Void>()
        let selectedTamagotchi = PublishSubject<Void>()
        
        input.cancelTapped
            .bind(to: popVC)
            .disposed(by: disposeBag)
        
        input.selectTapped
            .bind(with: self) { owner, tamagotchiName in
                UserDefaults.standard.set(tamagotchiName, forKey: UserDefaultsKey.nickname.value)
                popVC.onNext(())
            }
            .disposed(by: disposeBag)
        
        return Output(dismiss: popVC, select: selectedTamagotchi)
    }
}
