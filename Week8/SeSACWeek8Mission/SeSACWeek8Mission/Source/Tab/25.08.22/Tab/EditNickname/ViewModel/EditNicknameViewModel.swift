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
        let nickname: ControlProperty<String>
    }
    
    // MARK: - Output
    
    struct Output {
        
    }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        input.nickname
            .bind(with: self) { owner, nickname in
                UserDefaults.standard.set(nickname, forKey: UserDefaultsKey.nickname.value)
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
