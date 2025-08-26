//
//  LottoViewModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LottoViewModel: BaseViewModel {

    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Input
    
    struct Input {
        let searchTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    // MARK: - Output
    
    struct Output {
        let lottoResult: PublishRelay<String>
    }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let searchLotto = input.searchTap
        let lottoResult = PublishRelay<String>()
        
        searchLotto
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap { LottoObservable.getLottoNumber(query: $0) }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let lottoInfo):
                    lottoResult.accept("\(lottoInfo.first) \(lottoInfo.second) \(lottoInfo.third) \(lottoInfo.fourth) \(lottoInfo.fifth) \(lottoInfo.sixth) \(lottoInfo.bonus)")
                    
                case .failure(let error):
                    print("<< lotto error: \(error)")
                }
            }
            .disposed(by: disposeBag)
        
        return Output(lottoResult: lottoResult)
    }
}
