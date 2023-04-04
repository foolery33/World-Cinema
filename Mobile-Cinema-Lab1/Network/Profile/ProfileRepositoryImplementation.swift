//
//  ProfileRepositoryImplementation.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 03.04.2023.
//

import Foundation
import Alamofire

final class ProfileRepositoryImplementation: ProfileRepository {
    
    private let baseURL = "http://107684.web.hosting-russia.ru:8000/api"
    private let interceptor = CustomRequestInterceptor()
    
    func getProfile(completion: @escaping (Result<UserModel, AppError>) -> Void) {
        let url = baseURL + "/profile"
        AF.request(url, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Get profile Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(UserModel.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.profileError(.modelError)))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 401:
                        completion(.failure(.profileError(.unauthorized)))
                    case 500:
                        completion(.failure(.profileError(.serverError)))
                    default:
                        completion(.failure(.profileError(.unexpectedError)))
                    }
                }
            }
        }
    }
    
    func setAvatar(imageData: Data, completion: @escaping (Result<Bool, AppError>) -> Void) {
        let url = baseURL + "/profile/avatar"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(TokenManager.shared.fetchAccessToken())"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "fileset", fileName: "file.jpg", mimeType: "image/jpg")
        }, to: url, headers: headers).validate().responseData { response in
            switch response.result {
            case .success:
                print("Success")
                completion(.success(true))
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 400:
                        completion(.failure(.profileError(.somethingWentWrong)))
                    case 401:
                        completion(.failure(.profileError(.unauthorized)))
                    case 404:
                        completion(.failure(.profileError(.wrongEndpoint)))
                    case 500:
                        completion(.failure(.profileError(.serverError)))
                    default:
                        completion(.failure(.profileError(.unexpectedError)))
                    }
                }
            }
        }
    }
    
    enum ProfileError: Error, LocalizedError, Identifiable {
        case somethingWentWrong
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
            case .somethingWentWrong:
                return NSLocalizedString("Something went wrong. Please try again later", comment: "")
            case .wrongEndpoint:
                return NSLocalizedString("Endpoint provided in request is not valid. Please contact developer", comment: "")
            case .modelError:
                return NSLocalizedString("Internal application error. Please contact developer", comment: "")
            case .serverError:
                return NSLocalizedString("Some server error occured. Please try again later", comment: "")
            case .unauthorized:
                return NSLocalizedString("Your authentication token is expired. Please login again", comment: "")
            case .unexpectedError:
                return NSLocalizedString("Some unexpected error occured. Please contact developer", comment: "")
            }
        }
    }
    
}
