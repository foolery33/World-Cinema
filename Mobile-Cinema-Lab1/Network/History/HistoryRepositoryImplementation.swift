//
//  HistoryRepositoryImplementation.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 21.04.2023.
//

import Foundation
import Alamofire

final class HistoryRepositoryImplementation: HistoryRepository {
    
    private let baseURL = "http://107684.web.hosting-russia.ru:8000/api"
    private let interceptor = CustomRequestInterceptor()
    
    func getHistory(completion: @escaping (Result<[EpisodeViewModel], AppError>) -> Void) {
        let url = self.baseURL + "/history"
        AF.request(url, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Get history Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode([EpisodeViewModel].self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.chatsError(.modelError)))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 401:
                        completion(.failure(.chatsError(.unauthorized)))
                    case 404:
                        completion(.failure(.chatsError(.wrongEndpoint)))
                    case 500:
                        completion(.failure(.chatsError(.serverError)))
                    default:
                        completion(.failure(.chatsError(.unexpectedError)))
                    }
                }
            }
        }
    }
}
