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
                var message: String
                
                if owner.isValidNickname(nickname: nickname) {
                    UserDefaults.standard.set(nickname, forKey: UserDefaultsKey.nickname.value)
                    message = "닉네임 수정 완료!"
                } else {
                    message = "닉네임은 2글자 이상, 6글자 이하로 작성해주세요"
                }
                resultMessage.onNext(message)
            }
            .disposed(by: disposeBag)
        
        return Output(resultMessage: resultMessage)
    }
    
    // MARK: - 닉네임 유효성 검사
    
    private func isValidNickname(nickname: String) -> Bool {
        
        // 2글자 이상, 6글자 미만만 허용
        if nickname.count >= 2 && nickname.count <= 6 {
            return true
        } else {
            return false
        }
    }
}
