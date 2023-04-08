//
//  CustomRequestInterceptor.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 24.03.2023.
//

import Foundation
import Alamofire

class CustomRequestInterceptor: RequestInterceptor {
    private let retryLimit = 2
    private let retryDelay: TimeInterval = 1
    
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if !TokenManager.shared.fetchAccessToken().isEmpty {
            urlRequest.setValue("Bearer \(TokenManager.shared.fetchAccessToken())", forHTTPHeaderField: "Authorization")
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = (request.task?.response as? HTTPURLResponse)?.statusCode else {
            completion(.doNotRetry)
            return
        }
        switch statusCode {
        case 401:
            refreshToken { [weak self] in
                guard let self,
                  request.retryCount < self.retryLimit else {
                // Если уже попытались повторить запрос максимальное количество раз, то прекращаем попытки
                completion(.doNotRetry)
                return
            }
                completion(.retryWithDelay(self.retryDelay))
            }
        case (501...599):
            guard request.retryCount < retryLimit else { return }
            completion(.retryWithDelay(retryDelay))
        default:
            completion(.doNotRetry)
        }
    }
    
    private func refreshToken(completion: @escaping (() -> Void)) {
        print("refresh")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(TokenManager.shared.fetchRefreshToken())",
            "Content-Type": "application/json"
        ]
        let url = "http://107684.web.hosting-russia.ru:8000/api/auth/refresh"
        AF.request(url, method: .post, headers: headers).responseData { response in
            if let statusCode = response.response?.statusCode {
                print("Refresh Status Code:", statusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(AuthTokenPairModel.self, from: data)
                    TokenManager.shared.saveAccessToken(accessToken: decodedData.accessToken)
                    TokenManager.shared.saveRefreshToken(refreshToken: decodedData.refreshToken)
                    print(TokenManager.shared.fetchAccessToken())
                    completion()
                } catch {
                    completion()
                    return
                }
            case .failure(_):
                completion()
                return
            }
        }
    }
}
