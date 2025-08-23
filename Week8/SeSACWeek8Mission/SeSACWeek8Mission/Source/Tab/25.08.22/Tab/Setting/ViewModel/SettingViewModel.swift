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
    
//    // MARK: - DisposeBag
//    
//    private let disposeBag = DisposeBag()
//    
//    // MARK: - Input
//    
//    struct Input {
//        
//    }
    
    // MARK: - Output
    
    struct Output {
        let cellTitle: BehaviorSubject<[SettingModel]>
    }
    
    // MARK: - Init
    
    // MARK: - Transform
    
    func transform() -> Output {
        let settingData = BehaviorSubject(value: SettingModel.settingData)
        
        return Output(cellTitle: settingData)
    }
}
