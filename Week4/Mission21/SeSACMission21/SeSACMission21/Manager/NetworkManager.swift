//
//  NetworkManager.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/29/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    // API 요청 공통 함수
    func networkRequest<T: Decodable>(
        api: NetworkRouter,
        isRecommendSearching: Bool = false,
        model: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
        
            AF.request(api.endpoint, method: api.method, parameters: api.parameters, headers: api.headers)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: model.self) { response in
                    switch response.result {
                    case .success(let searchResult):
                        completion(.success(searchResult))
                        
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode {
                            completion(.failure(NetworkError.responseFail(statusCode: statusCode)))
                        }
                        // 200번대 성공 응답을 받았지만, 모델로 디코딩하는 과정에서 실패한 경우
                        // 예: 서버가 다른 형식의 JSON을 보냈거나, 필수 필드가 누락된 경우
                        else if error.isResponseSerializationError {
                            completion(.failure(NetworkError.decodingFailed))
                        }
                        // 명시적으로 처리하지 않은 응답 실패 경우
                        else {
                            completion(.failure(NetworkError.unknownError))
                        }
                    }
                }
    }
}
