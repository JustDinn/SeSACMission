//
//  BoxOfficeObservable.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

final class BoxOfficeObservable {
    
    static func getBoxOfficeInfo(query: String) -> Observable<Result<MovieModel, NetworkError>> {
        return Observable<Result<MovieModel, NetworkError>>.create { observer in
            guard let boxOfficeAPIKey = Bundle.main.infoDictionary?["BOX_OFFICE_API_KEY"] as? String else {
                return Disposables.create()
            }
            guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
                return Disposables.create()
            }
            let url = baseURL + "searchDailyBoxOfficeList.json?key=\(boxOfficeAPIKey)&targetDt=\(query)"
            
            AF.request(url, method: .get)
                .responseDecodable(of: MovieModel.self) { response in
                    switch response.result {
                    case .success(let boxOfficeInfo):
                        observer.onNext(.success(boxOfficeInfo))
                        observer.onCompleted()
                        
                    case .failure(let error):
                        if let afError = error.asAFError,
                           let urlError = afError.underlyingError as? URLError {
                            switch urlError.code {
                            case .notConnectedToInternet:
                                observer.onNext(.failure(.networkDisconnected))
                                observer.onCompleted()
                            default:
                                break
                            }
                        }
                        
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
