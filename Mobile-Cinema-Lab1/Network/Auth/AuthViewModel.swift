//
//  AuthViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 24.03.2023.
//

import Foundation
import Alamofire

class AuthViewModel {
    
    static let shared: AuthViewModel = AuthViewModel()
    
    private let baseURL = "http://107684.web.hosting-russia.ru:8000/api"
    private let interceptor = CustomRequestInterceptor()
    
    func login(email: String, password: String, completion: @escaping (Result<AuthTokenPairModel, AppError>) -> Void) {
        let url = baseURL + "/auth/login"
        let httpParameters = [
            "email": email,
            "password": password
        ]
        DispatchQueue.main.async {
            AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default, interceptor: self.interceptor).validate().responseData { response in
                if let requestStatusCode = response.response?.statusCode {
                    print("Login Status Code: ", requestStatusCode)
                }
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(AuthTokenPairModel.self, from: data)
                        TokenManager.shared.saveAccessToken(accessToken: decodedData.accessToken)
                        completion(.success(decodedData))
                    } catch(_) {
                        completion(.failure(.authError(.modelError)))
                    }
                case .failure(_):
                    if let requestStatusCode = response.response?.statusCode {
                        switch requestStatusCode {
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
        print(httpParameters)
        DispatchQueue.main.async {
            AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default, interceptor: self.interceptor).validate().responseData { response in
                if let requestStatusCode = response.response?.statusCode {
                    print("Register Status Code: ", requestStatusCode)
                }
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(AuthTokenPairModel.self, from: data)
                        TokenManager.shared.saveAccessToken(accessToken: decodedData.accessToken)
                        completion(.success(decodedData))
                    } catch(_) {
                        completion(.failure(.authError(.modelError)))
                    }
                case .failure(_):
                    if let requestStatusCode = response.response?.statusCode {
                        switch requestStatusCode {
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
                return NSLocalizedString("Internal application error. Please contact developer", comment: "")
            case .invalidCredentials:
                return NSLocalizedString("Either your email or password are incorrect. Please try again", comment: "")
            case .loginValidationError:
                return NSLocalizedString("Some validation error", comment: "")
            case .serverError:
                return NSLocalizedString("Some server error occured. Please try again later", comment: "")
            case .emptyField:
                return NSLocalizedString("Please make sure that you've provided all necessary data", comment: "")
            case .invalidEmail:
                return NSLocalizedString("Your email does not conform to default email pattern", comment: "")
            case .differentPasswords:
                return NSLocalizedString("You've provided different passwords. Make sure they are equal", comment: "")
            }
        }
    }
    
}
