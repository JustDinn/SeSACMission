//
//  EditNicknameViewModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/23/25.
//

import Foundation
import RxSwift
import RxCocoa

final class EditNicknameViewModel {
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Input
    
    struct Input {
        let saveButtonTapped: ControlEvent<Void>
        let nickname: ControlProperty<String>
    }
    
    // MARK: - Output
    
    struct Output {
        let resultMessage: PublishSubject<String>
    }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let resultMessage = PublishSubject<String>()
        
        input.saveButtonTapped
            .withLatestFrom(input.nickname)
            .bind(with: self) { owner, nickname in
                UserDefaults.standard.set(nickname, forKey: UserDefaultsKey.nickname.value)
                resultMessage.onNext("닉네임 수정 완료!")
            }
            .disposed(by: disposeBag)
        
        return Output(resultMessage: resultMessage)
    }
}
