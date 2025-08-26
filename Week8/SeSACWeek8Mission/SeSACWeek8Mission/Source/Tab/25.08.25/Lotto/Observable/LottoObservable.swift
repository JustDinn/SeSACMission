//
//  LottoObservable.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/26/25.
//

import RxSwift
import RxCocoa
import Alamofire

enum LottoError: Error {
    case invalid
}

final class LottoObservable {
    
    static func getLottoNumber(query: String) -> Observable<Result<LottoModel, LottoError>> {
        return Observable<Result<LottoModel, LottoError>>.create { observer in
            let endpoint = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            
            AF.request(endpoint, method: .get)
                .responseDecodable(of: LottoModel.self) { response in
                    switch response.result {
                    case .success(let lottoNumbers):
                        observer.onNext(.success(lottoNumbers))
                        observer.onCompleted()
                        
                    case .failure:
                        observer.onNext(.failure(.invalid))
                        observer.onCompleted()
                    }
                }
            
            return Disposables.create()
        }
    }
}
