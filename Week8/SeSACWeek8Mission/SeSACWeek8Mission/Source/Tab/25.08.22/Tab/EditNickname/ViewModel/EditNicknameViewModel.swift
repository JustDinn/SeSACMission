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
    }
    
    // MARK: - Output
    
    struct Output {
        
    }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        input.saveButtonTapped
            .bind(with: self) { owner, _ in
                
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
