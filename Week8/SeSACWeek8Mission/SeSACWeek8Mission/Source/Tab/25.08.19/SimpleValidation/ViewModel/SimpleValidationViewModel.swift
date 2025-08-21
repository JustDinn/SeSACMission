//
//  SimpleValidationViewModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/22/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SimpleValidationViewModel {
    
    // MARK: - Property
    
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Input
    
    struct Input {
        let usernameText: ControlProperty<String>
        let passwordText: ControlProperty<String>
        let doneButtonTapped: ControlEvent<Void>
    }
    
    // MARK: - Output
    
    struct Output {
        let usernameValid: BehaviorSubject<Bool>
        let passwordValid: BehaviorSubject<Bool>
        let everythingValid: BehaviorSubject<Bool>
        let showAlert: PublishSubject<(String, String)>
    }
    
    // MARK: - Init
    
    init() { }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let usernameValid = BehaviorSubject(value: false)
        let passwordValid = BehaviorSubject(value: false)
        let everythingValid = BehaviorSubject(value: false)
        let showAlert = PublishSubject<(String, String)>()
        
        let isValidUsername = input.usernameText
            .map { $0.count >= self.minimalUsernameLength }
            .share(replay: 1)
        
        let isValidPassword = input.passwordText
            .map { $0.count >= self.minimalPasswordLength }
            .share(replay: 1)
        
        let isValidEverything = Observable.combineLatest(isValidUsername, isValidPassword) { $0 && $1 }
            .share(replay: 1)
        
        isValidUsername
            .bind(with: self, onNext: { owner, isValid in
                usernameValid.onNext(isValid)
            })
            .disposed(by: disposeBag)
        
        isValidPassword
            .bind(with: self, onNext: { owner, isValid in
                passwordValid.onNext(isValid)
            })
            .disposed(by: disposeBag)
        
        isValidEverything
            .bind(with: self, onNext: { owner, isValid in
                everythingValid.onNext(isValid)
            })
            .disposed(by: disposeBag)
        
        input.doneButtonTapped
            .bind(with: self, onNext: { owner, _ in
                showAlert.onNext(("경축", "유효성 검사 통과"))
            })
            .disposed(by: disposeBag)
        
        return Output(
            usernameValid: usernameValid,
            passwordValid: passwordValid,
            everythingValid: everythingValid,
            showAlert: showAlert
        )
    }
}
