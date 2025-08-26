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
        let errorMessage: PublishRelay<String>
    }
    
    // MARK: - Transform
    
    func transform(input: In) -> Out {
        let result = PublishRelay<[MovieInfo]>()
        let errorMessage = PublishRelay<String>()
        
        input.searchButtonTapped
            .withLatestFrom(input.searchKeyword)
            .distinctUntilChanged()
            .flatMap {
                BoxOfficeObservable
                    .getBoxOfficeInfo(query: $0)
                    .catch { error in
                        return Observable.never()
                    }
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let boxOfficeInfo):
                    result.accept(boxOfficeInfo.movie.movieList)
                    
                case .failure(let error):
                    switch error {
                    case .badRequest:
                        errorMessage.accept("[400] 잘못된 요청입니다")
                    case .unAuthorized:
                        errorMessage.accept("[401] 토큰 만료 혹은 잘못된 토큰입니다")
                    case .notFound:
                        errorMessage.accept("[404] 요청받은 리소스를 찾을 수 없습니다")
                    case .serverError:
                        errorMessage.accept("[500] 서버 에러입니다")
                    case .networkDisconnected:
                        errorMessage.accept("[네트워크] 인터넷 연결을 확인해주세요")
                    case .unknownError:
                        errorMessage.accept("[Unknown] 알 수 없는 에러가 발생했습니다")
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Out(result: result, errorMessage: errorMessage)
    }
}
