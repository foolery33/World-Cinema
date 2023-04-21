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
                    completion(.failure(.historyError(.modelError)))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 401:
                        completion(.failure(.historyError(.unauthorized)))
                    case 404:
                        completion(.failure(.historyError(.wrongEndpoint)))
                    case 500:
                        completion(.failure(.historyError(.serverError)))
                    default:
                        completion(.failure(.historyError(.unexpectedError)))
                    }
                }
            }
        }
    }
    
    enum HistoryError: Error, LocalizedError, Identifiable {
        case wrongEndpoint
        case modelError
        case serverError
        case unauthorized
        case unexpectedError
        var id: String {
            self.errorDescription
        }
        var errorDescription: String {
            switch self {
            case .wrongEndpoint:
                return R.string.errors.wrong_endpoint()
            case .modelError:
                return R.string.errors.model_error()
            case .serverError:
                return R.string.errors.server_error()
            case .unauthorized:
                return R.string.errors.unauthorized()
            case .unexpectedError:
                return R.string.errors.unexpected_error()
            }
        }
    }
    
}
