//
//  EpisodeRepositoryImplementation.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 12.04.2023.
//

import Foundation
import Alamofire

final class EpisodesRepositoryImplementation: EpisodesRepository {
    
    private let baseURL = "http://107684.web.hosting-russia.ru:8000/api"
    private let interceptor = CustomRequestInterceptor()
    
    func getEpisodeComments(episodeId: String, completion: @escaping (Result<[CommentModel], AppError>) -> Void) {
        
    }
    
    func postEpisodeComment(episodeId: String, completion: @escaping (Result<[CommentModel], AppError>) -> Void) {
        
    }
    
    func getEpisodeTime(episodeId: String, completion: @escaping (Result<EpisodeTimeModel, AppError>) -> Void) {
        let url = baseURL + "/episodes/\(episodeId)/time"
        AF.request(url, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Get episode time Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(EpisodeTimeModel.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.episodesError(.modelError)))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 401:
                        completion(.failure(.episodesError(.unauthorized)))
                    case 404:
                        completion(.failure(.episodesError(.wrongEndpoint)))
                    case 422:
                        completion(.failure(.episodesError(.unknownRequestParameter)))
                    case 500:
                        completion(.failure(.episodesError(.serverError)))
                    default:
                        completion(.failure(.episodesError(.unexpectedError)))
                    }
                }
            }
        }
    }
    
    func saveEpisodeTime(episodeId: String, timeInSeconds: Int, completion: @escaping (Result<Bool, AppError>) -> Void) {
        let url = baseURL + "/episodes/\(episodeId)/time"
        let httpParameters = [
            "timeInSeconds": timeInSeconds
        ]
        AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Save episode time Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 400:
                        completion(.failure(.episodesError(.problemWithSave)))
                    case 401:
                        completion(.failure(.episodesError(.unauthorized)))
                    case 404:
                        completion(.failure(.episodesError(.wrongEndpoint)))
                    case 422:
                        completion(.failure(.episodesError(.unknownRequestParameter)))
                    case 500:
                        completion(.failure(.episodesError(.serverError)))
                    default:
                        completion(.failure(.episodesError(.unexpectedError)))
                    }
                }
            }
        }
    }
    
    enum EpisodesError: Error, LocalizedError, Identifiable {
        case problemWithSave
        case wrongEndpoint
        case modelError
        case serverError
        case unknownRequestParameter
        case unauthorized
        case unexpectedError
        var id: String {
            self.errorDescription
        }
        var errorDescription: String {
            switch self {
            case .problemWithSave:
                return NSLocalizedString("Some problem with comment saving occured", comment: "")
            case .wrongEndpoint:
                return NSLocalizedString("Endpoint provided in request is not valid. Please contact developer", comment: "")
            case .modelError:
                return NSLocalizedString("Internal application error. Please contact developer", comment: "")
            case .serverError:
                return NSLocalizedString("Some server error occured. Please try again later", comment: "")
            case .unknownRequestParameter:
                return NSLocalizedString("Wrong episode id was provided. Please contact developer", comment: "")
            case .unauthorized:
                return NSLocalizedString("Your authentication token is expired. Please login again", comment: "")
            case .unexpectedError:
                return NSLocalizedString("Some unexpected error occured. Please contact developer", comment: "")
            }
        }
    }
    
}
