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
    
    // MARK: - Property
    
    private var settingData = SettingModel.settingData
    private let settingDataSubject = BehaviorSubject(value: SettingModel.settingData)
    
    // MARK: - Input
    
    struct Input {
        let selectedCell: ControlEvent<IndexPath>
    }
    
    // MARK: - Output
    
    struct Output {
        let cellTitle: BehaviorSubject<[SettingModel]>
        let pushedVC: PublishSubject<Int>
        let resetTapped: PublishSubject<Void>
    }
    
    // MARK: - Init
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let pushedVC = PublishSubject<Int>()
        let resetTapped = PublishSubject<Void>()
        
        input.selectedCell
            .bind(with: self) { owner, indexPath in
                if indexPath.row == 2 {
                    resetTapped.onNext(())
                } else {
                    let row = indexPath.row
                    pushedVC.onNext(row)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(cellTitle: settingDataSubject,
                      pushedVC: pushedVC,
                      resetTapped: resetTapped)
    }
    
    // MARK: - 닉네임 업데이트
    
    func updateNickname() {
        let nickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.value) ?? ""
        
        settingData[0] = SettingModel(
            icon: settingData[0].icon,
            title: settingData[0].title,
            nickname: nickname
        )
        settingDataSubject.onNext(settingData)
    }
}
