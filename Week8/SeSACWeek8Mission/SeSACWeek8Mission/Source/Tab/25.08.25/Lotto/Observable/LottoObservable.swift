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
    
    static func getLottoNumber(query: String) -> Observable<LottoModel> {
        return Observable<LottoModel>.create { observer in
            let endpoint = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            
            AF.request(endpoint, method: .get)
                .responseDecodable(of: LottoModel.self) { response in
                    switch response.result {
                    case .success(let lottoNumbers):
                        observer.onNext(lottoNumbers)
                        observer.onCompleted()
                        
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create()
        }
    }
}
