//
//  SettingViewModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/22/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel {
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Input
    
    struct Input {
        let selectedCell: ControlEvent<IndexPath>
    }
    
    // MARK: - Output
    
    struct Output {
        let cellTitle: BehaviorSubject<[SettingModel]>
        let pushedVC: PublishSubject<Void>
    }
    
    // MARK: - Init
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let settingData = BehaviorSubject(value: SettingModel.settingData)
        let pushedVC = PublishSubject<Void>()
        
        input.selectedCell
            .bind(with: self) { owner, indexPath in
                if indexPath.row == 0 {
                    pushedVC.onNext(())
                }
            }
            .disposed(by: disposeBag)
        
        return Output(cellTitle: settingData, pushedVC: pushedVC)
    }
}
