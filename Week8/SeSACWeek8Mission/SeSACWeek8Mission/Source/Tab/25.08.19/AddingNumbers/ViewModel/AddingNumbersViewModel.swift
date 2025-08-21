//
//  AddingNumbersViewModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/22/25.
//

import Foundation
import RxSwift
import RxCocoa

final class AddingNumbersViewModel {
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Input
    
    struct Input {
        let firstNumberText: ControlProperty<String>
        let secondNumberText: ControlProperty<String>
        let thirdNumberText: ControlProperty<String>
    }
    
    // MARK: - Output
    
    struct Output {
        let resultText: BehaviorSubject<String>
    }
    
    // MARK: - Init
    
    init() { }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let resultText = BehaviorSubject(value: "0")
        
        Observable.combineLatest(
            input.firstNumberText,
            input.secondNumberText,
            input.thirdNumberText) { firstText, secondText, thirdText -> Int in
                return (Int(firstText) ?? 0) + (Int(secondText) ?? 0) + (Int(thirdText) ?? 0)
            }
            .map { $0.description }
            .bind(with: self, onNext: { owner, text in
                resultText.onNext(text)
            })
            .disposed(by: disposeBag)
        
        return Output(resultText: resultText)
    }
}
