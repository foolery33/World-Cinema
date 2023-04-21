//
//  CoverRepositoryImplementation.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 02.04.2023.
//

import Foundation
import Alamofire

final class CoverRepositoryImplementation: CoverRepository {
    
    private let baseURL = "http://107684.web.hosting-russia.ru:8000/api"
    private let interceptor = CustomRequestInterceptor()
    
    func getCover(completion: @escaping (Result<CoverModel, AppError>) -> Void) {
        let url = baseURL + "/cover"
        AF.request(url, method: .get, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Get cover Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(CoverModel.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.coverError(.modelError)))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 401:
                        completion(.failure(.coverError(.unauthorized)))
                    case 404:
                        completion(.failure(.coverError(.noCover)))
                    case 500:
                        completion(.failure(.coverError(.serverError)))
                    default:
                        completion(.failure(.coverError(.unexpectedError)))
                    }
                }
            }
        }
    }
    
    enum CoverError: Error, LocalizedError, Identifiable {
        case modelError
        case serverError
        case unauthorized
        case unexpectedError
        case noCover
        var id: String {
            self.errorDescription
        }
        var errorDescription: String {
            switch self {
            case .modelError:
                return R.string.errors.model_error()
            case .serverError:
                return R.string.errors.server_error()
            case .unauthorized:
                return R.string.errors.unauthorized()
            case .unexpectedError:
                return R.string.errors.unexpected_error()
            case .noCover:
                return R.string.errors.no_cover()
            }
        }
    }
    
}
