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
    
    func getChatMessages(chatId: String, completion: @escaping (Result<[MessageModel], AppError>) -> Void) {
        
    }
    
    func postMessageToChat(chatId: String, completion: @escaping (Result<MessageModel, AppError>) -> Void) {
        
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
                return NSLocalizedString("Endpoint provided in request is not valid. Please contact developer", comment: "")
            case .modelError:
                return NSLocalizedString("Internal application error. Please contact developer", comment: "")
            case .serverError:
                return NSLocalizedString("Some server error occured. Please try again later", comment: "")
            case .unknownRequestParameter:
                return NSLocalizedString("Unknown request parameter was provided. Please contact developer", comment: "")
            case .noQueryParameter:
                return NSLocalizedString("No query parameter was provided. Please contact developer", comment: "")
            case .unauthorized:
                return NSLocalizedString("Your authentication token is expired. Please login again", comment: "")
            case .unexpectedError:
                return NSLocalizedString("Some unexpected error occured. Please contact developer", comment: "")
            case .emptyField:
                return NSLocalizedString("Please make sure you provided text to send", comment: "")
            }
        }
    }
    
}
