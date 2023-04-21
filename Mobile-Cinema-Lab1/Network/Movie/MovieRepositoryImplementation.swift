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
                        completion(.failure(.movieError(.unknownRequestParameter)))
                    case 500:
                        completion(.failure(.movieError(.serverError)))
                    default:
                        completion(.failure(.movieError(.unexpectedError)))
                    }
                }
            }
        }
    }
    
    func getMovieEpisodesById(movieId: String, completion: @escaping (Result<[EpisodeModel], AppError>) -> Void) {
        let url = baseURL + "/movies/\(movieId)/episodes"
        AF.request(url, method: .get, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Get episodes by id Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode([EpisodeModel].self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.movieError(.modelError)))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 401:
                        completion(.failure(.movieError(.unauthorized)))
                    case 404:
                        completion(.failure(.movieError(.wrongEndpoint)))
                    case 422:
                        completion(.failure(.movieError(.unknownRequestParameter)))
                    case 500:
                        completion(.failure(.movieError(.serverError)))
                    default:
                        completion(.failure(.movieError(.unexpectedError)))
                    }
                }
            }
        }
    }
    
    func dislikeMovie(movieId: String, completion: @escaping (Result<Bool, AppError>) -> Void) {
        let url = baseURL + "/movies/\(movieId)/dislike"
        AF.request(url, method: .post, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Dislike movie Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 401:
                        completion(.failure(.movieError(.unauthorized)))
                    case 404:
                        completion(.failure(.movieError(.wrongEndpoint)))
                    case 422:
                        completion(.failure(.movieError(.unknownRequestParameter)))
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
        case wrongEndpoint
        case modelError
        case serverError
        case unknownRequestParameter
        case noQueryParameter
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
            case .unknownRequestParameter:
                return R.string.errors.unknown_request_parameter()
            case .noQueryParameter:
                return R.string.errors.no_query_parameter()
            case .unauthorized:
                return R.string.errors.unauthorized()
            case .unexpectedError:
                return R.string.errors.unexpected_error()
            }
        }
    }
}
