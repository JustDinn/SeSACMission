//
//  MainViewModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/25/25.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel {
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Property
    
    private let riceCountSubject = BehaviorSubject<Int>(value: 0)
    private let waterCountSubject = BehaviorSubject<Int>(value: 0)
    private let levelSubject = BehaviorSubject<Int>(value: 1)
    
    // MARK: - Input
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let riceButtonTapped: Observable<Int>
        let waterButtonTapped: Observable<Int>
    }
    
    // MARK: - Output
    
    struct Output {
        let randomGreeting: Observable<String>
        let riceCount: BehaviorSubject<Int>
        let waterCount: BehaviorSubject<Int>
        let level: BehaviorSubject<Int>
    }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        input.riceButtonTapped
            .bind(with: self) { owner, riceCount in
                let currentRiceCount = try! owner.riceCountSubject.value()
                let riceCount = currentRiceCount + riceCount
                
                owner.riceCountSubject.onNext(riceCount)
                owner.updateLevel()
            }
            .disposed(by: disposeBag)
        
        input.waterButtonTapped
            .bind(with: self) { owner, waterCount in
                let currentWaterCount = try! owner.waterCountSubject.value()
                let waterCount = currentWaterCount + waterCount
                
                owner.waterCountSubject.onNext(waterCount)
                owner.updateLevel()
            }
            .disposed(by: disposeBag)
        
        let randomGreeting = PublishSubject<String>()
        
        input.viewWillAppear
            .bind(with: self) { owner, _ in
                let greeting = owner.getRandomGreeting()
                randomGreeting.onNext(greeting)
            }
            .disposed(by: disposeBag)
        
        return Output(
            randomGreeting: randomGreeting,
            riceCount: riceCountSubject,
            waterCount: waterCountSubject,
            level: levelSubject
        )
    }
    
    // MARK: - Private Methods
    
    private func getRandomGreeting() -> String {
        guard let tamagotchiName = UserDefaults.standard.string(forKey: UserDefaultsKey.tamagotchiName.value) else {
            return ""
        }
        
        guard let selectedTamagotchi = TamagotchiModel.tamagotchies.first(where: { $0.name == tamagotchiName }) else {
            return ""
        }
        
        return selectedTamagotchi.greeting.randomElement() ?? ""
    }
    
    private func calculateLevel(riceCount: Int, waterCount: Int) -> Int {
        let calculatedLevel = Int((Double(riceCount) / 5.0) + (Double(waterCount) / 2.0))
        let level = max(1, min(calculatedLevel, 10))
        
        UserDefaults.standard.set(level, forKey: UserDefaultsKey.level.value)
        
        return level
    }
    
    private func updateLevel() {
        let riceCount = try! riceCountSubject.value()
        let waterCount = try! waterCountSubject.value()
        let newLevel = calculateLevel(riceCount: riceCount, waterCount: waterCount)
        levelSubject.onNext(newLevel)
    }
}
