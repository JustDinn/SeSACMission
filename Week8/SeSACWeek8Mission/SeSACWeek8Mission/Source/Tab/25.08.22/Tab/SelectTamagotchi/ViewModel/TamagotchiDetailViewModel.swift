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
        let selectTapped: PublishSubject<TamagotchiModel>
    }
    
    // MARK: - Output
    
    struct Output {
        let dismiss: PublishSubject<Void>
        let select: PublishSubject<Void>
        let pushMainVC: PublishSubject<Void>
    }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let popVC = PublishSubject<Void>()
        let selectedTamagotchi = PublishSubject<Void>()
        let pushMainVC = PublishSubject<Void>()
        
        input.cancelTapped
            .bind(to: popVC)
            .disposed(by: disposeBag)
        
        input.selectTapped
            .bind(with: self) { owner, tamagotchi in
                let isExistTamagotchi = UserDefaults.standard.string(forKey: UserDefaultsKey.tamagotchiName.value)
                
                UserDefaults.standard.set(tamagotchi.name, forKey: UserDefaultsKey.tamagotchiName.value)
                UserDefaults.standard.set(tamagotchi.image, forKey: UserDefaultsKey.tamagotchiImage.value)
                if isExistTamagotchi == nil {
                    pushMainVC.onNext(())
                } else {
                    popVC.onNext(())
                }
            }
            .disposed(by: disposeBag)
        
        return Output(dismiss: popVC, select: selectedTamagotchi, pushMainVC: pushMainVC)
    }
}
