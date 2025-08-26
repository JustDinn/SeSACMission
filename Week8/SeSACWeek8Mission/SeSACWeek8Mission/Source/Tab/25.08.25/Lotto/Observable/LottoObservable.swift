//
//  LottoObservable.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

import RxSwift
import RxCocoa
import Alamofire

final class LottoObservable {
    
    static func getLottoNumber(query: String) -> Observable<Result<LottoModel, NetworkError>> {
        return Observable<Result<LottoModel, NetworkError>>.create { observer in
            let endpoint = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            
            AF.request(endpoint, method: .get)
                .responseDecodable(of: LottoModel.self) { response in
                    switch response.result {
                    case .success(let lottoNumbers):
                        observer.onNext(.success(lottoNumbers))
                        observer.onCompleted()
                        
                    case .failure(let error):
                        let statusCode = error.responseCode
                        
                        switch statusCode {
                        case 400:
                            observer.onNext(.failure(.badRequest))
                        case 401:
                            observer.onNext(.failure(.unAuthorized))
                        case 404:
                            observer.onNext(.failure(.notFound))
                        case 500:
                            observer.onNext(.failure(.serverError))
                        default:
                            observer.onNext(.failure(.unknownError))
                        }
                        observer.onCompleted()
                    }
                }
            return Disposables.create()
        }
    }
}
