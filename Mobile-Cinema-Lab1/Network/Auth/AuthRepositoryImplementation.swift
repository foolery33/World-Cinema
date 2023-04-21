//
//  AuthViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 24.03.2023.
//

import Foundation
import Alamofire

class AuthRepositoryImplementation: AuthRepository {
    
    private let baseURL = "http://107684.web.hosting-russia.ru:8000/api"
    private let interceptor = CustomRequestInterceptor()
    
    func login(email: String, password: String, completion: @escaping (Result<AuthTokenPairModel, AppError>) -> Void) {
        let url = baseURL + "/auth/login"
        let httpParameters = [
            "email": email,
            "password": password
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        DispatchQueue.global(qos: .userInitiated).async {
            AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default, headers: headers).validate().responseData { response in
                if let requestStatusCode = response.response?.statusCode {
                    print("Login Status Code: ", requestStatusCode)
                }
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(AuthTokenPairModel.self, from: data)
                        TokenManager.shared.saveAccessToken(accessToken: decodedData.accessToken)
                        TokenManager.shared.saveRefreshToken(refreshToken: decodedData.refreshToken)
                        completion(.success(decodedData))
                    } catch(_) {
                        completion(.failure(.authError(.modelError)))
                    }
                case .failure(_):
                    if let requestStatusCode = response.response?.statusCode {
                        switch requestStatusCode {
                        case 401:
                            completion(.failure(.authError(.invalidCredentials)))
                        case 422:
                            completion(.failure(.authError(.loginValidationError)))
                        case 500:
                            completion(.failure(.authError(.serverError)))
                        default:
                            completion(.failure(.authError(.serverError)))
                        }
                    }
                }
            }
        }
    }
    
    func register(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Result<AuthTokenPairModel, AppError>) -> Void) {
        let url = baseURL + "/auth/register"
        let httpParameters = [
            "email": email,
            "password": password,
            "firstName": firstName,
            "lastName": lastName
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        print(httpParameters)
        DispatchQueue.global(qos: .userInitiated).async {
            AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default, headers: headers).validate().responseData { response in
                if let requestStatusCode = response.response?.statusCode {
                    print("Register Status Code: ", requestStatusCode)
                }
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(AuthTokenPairModel.self, from: data)
                        TokenManager.shared.saveAccessToken(accessToken: decodedData.accessToken)
                        TokenManager.shared.saveRefreshToken(refreshToken: decodedData.refreshToken)
                        completion(.success(decodedData))
                    } catch(_) {
                        completion(.failure(.authError(.modelError)))
                    }
                case .failure(_):
                    if let requestStatusCode = response.response?.statusCode {
                        switch requestStatusCode {
                        case 401:
                            completion(.failure(.authError(.invalidCredentials)))
                        case 422:
                            completion(.failure(.authError(.loginValidationError)))
                        case 500:
                            completion(.failure(.authError(.serverError)))
                        default:
                            completion(.failure(.authError(.serverError)))
                        }
                    }
                }
            }
        }
    }
    
    enum AuthError: Error, LocalizedError, Identifiable {
        case modelError
        case invalidCredentials
        case loginValidationError
        case serverError
        case emptyField
        case invalidEmail
        case differentPasswords
        var id: String {
            self.errorDescription
        }
        var errorDescription: String {
            switch self {
            case .modelError:
                return R.string.errors.model_error()
            case .invalidCredentials:
                return R.string.errors.invalid_credentials()
            case .loginValidationError:
                return R.string.errors.login_validation_error()
            case .serverError:
                return R.string.errors.server_error()
            case .emptyField:
                return R.string.errors.empty_field()
            case .invalidEmail:
                return R.string.errors.invalid_email()
            case .differentPasswords:
                return R.string.errors.different_passwords()
            }
        }
    }
    
}
