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
        let cellTitle: BehaviorSubject<[String]>
    }
    
    // MARK: - Init
    
    // MARK: - Transform
    
    func transform() -> Output {
        let settingData = BehaviorSubject(value: ["내 이름 설정하기", "다마고치 변경하기", "데이터 초기화"])
        
        return Output(cellTitle: settingData)
    }
}
