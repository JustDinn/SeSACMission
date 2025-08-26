//
//  BoxOfficeViewModel.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class BoxOfficeViewModel: BaseViewModel {
    
    // MARK: Property
    
    typealias In = Input
    typealias Out = Output
    private let disposeBag = DisposeBag()
    
    // MARK: - Input
    
    struct Input {
        let searchButtonTapped: ControlEvent<Void>
        let searchKeyword: ControlProperty<String>
    }
    
    // MARK: - Output
    
    struct Output {
        let result: PublishRelay<[MovieInfo]>
    }
    
    // MARK: - Transform
    
    func transform(input: In) -> Out {
        let result = PublishRelay<[MovieInfo]>()
        
        input.searchButtonTapped
            .withLatestFrom(input.searchKeyword)
            .distinctUntilChanged()
            .flatMap {
                BoxOfficeObservable
                    .getBoxOfficeInfo(query: $0)
                    .catch { _ in
                        return Observable.never()
                    }
            }
            .bind(with: self) { owner, boxOfficeInfo in
                result.accept(boxOfficeInfo.movie.movieList)
            }
            .disposed(by: disposeBag)
        
        return Out(result: result)
    }
}
