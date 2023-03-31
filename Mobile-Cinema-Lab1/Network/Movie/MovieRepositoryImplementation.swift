//
//  MovieViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 28.03.2023.
//

import Foundation
import Alamofire

class MovieRepositoryImplementation: MovieRepository {
    
    private let baseURL = "http://107684.web.hosting-russia.ru:8000/api"
    private let interceptor = CustomRequestInterceptor()
    
    func getMovies(queryParameter: String, completion: @escaping (Result<[MovieModel], AppError>) -> Void) {
        let url = baseURL + "/movies"
        let htttpParameters = [
            "filter": queryParameter
        ]
        AF.request(url, method: .get, parameters: htttpParameters, encoding: URLEncoding.queryString, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Get \(queryParameter) movies Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode([MovieModel].self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.movieError(.modelError)))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 400:
                        completion(.failure(.movieError(.noQueryParameter)))
                    case 401:
                        completion(.failure(.movieError(.unauthorized)))
                    case 404:
                        completion(.failure(.movieError(.unknownQueryParameter)))
                    case 500:
                        completion(.failure(.movieError(.serverError)))
                    default:
                        completion(.failure(.movieError(.unexpectedError)))
                    }
                }
            }
        }
    }
                            
    enum MovieError: Error, LocalizedError, Identifiable {
        case modelError
        case serverError
        case unknownQueryParameter
        case noQueryParameter
        case unauthorized
        case unexpectedError
        var id: String {
            self.errorDescription
        }
        var errorDescription: String {
            switch self {
            case .modelError:
                return NSLocalizedString("Internal application error. Please contact developer", comment: "")
            case .serverError:
                return NSLocalizedString("Some server error occured. Please try again later", comment: "")
            case .unknownQueryParameter:
                return NSLocalizedString("Unknown query parameter was provided. Please contact developer", comment: "")
            case .noQueryParameter:
                return NSLocalizedString("No query parameter was provided. Please contact developer", comment: "")
            case .unauthorized:
                return NSLocalizedString("Your authentication token is expired. Please login again", comment: "")
            case .unexpectedError:
                return NSLocalizedString("Some unexpected error occured. Please contact developer", comment: "")
            }
        }
    }
}
