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
    }
    
    // MARK: - Output
    
    struct Output {
        let dismiss: PublishSubject<Void>
    }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let popVC = PublishSubject<Void>()
        
        input.cancelTapped
            .bind(to: popVC)
            .disposed(by: disposeBag)
        
        return Output(dismiss: popVC)
    }
}
