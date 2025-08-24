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
    
    // MARK: - Input
    
    struct Input {
        let viewWillAppear: Observable<Void>
    }
    
    // MARK: - Output
    
    struct Output {
        let randomGreeting: Observable<String>
    }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let randomGreeting = input.viewWillAppear
            .map { _ in
                self.getRandomGreeting()
            }
        
        return Output(randomGreeting: randomGreeting)
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
}
