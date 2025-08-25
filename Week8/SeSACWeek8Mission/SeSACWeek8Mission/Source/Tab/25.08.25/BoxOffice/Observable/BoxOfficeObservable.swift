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

enum BoxOfficeError: Error {
    case Invalid
}

final class BoxOfficeObservable {
    
    static func getBoxOfficeInfo(query: String) -> Observable<MovieModel> {
        return Observable<MovieModel>.create { observer in
            guard let boxOfficeAPIKey = Bundle.main.infoDictionary?["BOX_OFFICE_API_KEY"] as? String else {
                return Disposables.create()
            }
            let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(boxOfficeAPIKey)&targetDt=\(query)"
            
            AF.request(url, method: .get)
                .responseDecodable(of: MovieModel.self) { response in
                    switch response.result {
                    case .success(let boxOfficeInfo):
                        observer.onNext(boxOfficeInfo)
                        observer.onCompleted()
                        
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create()
        }
    }
}
