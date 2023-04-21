//
//  ChatsRepositoryImplementation.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import Foundation
import Alamofire

final class ChatsRepositoryImplementation: ChatsRepository {
    
    private let baseURL = "http://107684.web.hosting-russia.ru:8000/api"
    private let interceptor = CustomRequestInterceptor()
    
    func getChatList(completion: @escaping (Result<[ChatModel], AppError>) -> Void) {
        let url = self.baseURL + "/chats"
        AF.request(url, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Get chat list Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode([ChatModel].self, from: data)
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
    
    enum ChatsError: Error, LocalizedError, Identifiable {
        case wrongEndpoint
        case modelError
        case serverError
        case unknownRequestParameter
        case noQueryParameter
        case unauthorized
        case unexpectedError
        case emptyField
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
            case .emptyField:
                return R.string.errors.empty_field()
            }
        }
    }
    
}
