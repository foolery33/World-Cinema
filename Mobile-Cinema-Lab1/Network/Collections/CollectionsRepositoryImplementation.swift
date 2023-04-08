//
//  CollectionsRepositoryImplementation.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import Foundation
import Alamofire

final class CollectionsRepositoryImplementation: CollectionsRepository {
    
    private let baseURL = "http://107684.web.hosting-russia.ru:8000/api"
    private let interceptor = CustomRequestInterceptor()
    
    func getCollections(completion: @escaping (Result<[CollectionModel], AppError>) -> Void) {
        let url = baseURL + "/collections"
        AF.request(url, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Get collections Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode([CollectionModel].self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.collectionsError(.modelError)))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 401:
                        completion(.failure(.collectionsError(.unauthorized)))
                    case 404:
                        completion(.failure(.collectionsError(.wrongEndpoint)))
                    case 500:
                        completion(.failure(.collectionsError(.serverError)))
                    default:
                        completion(.failure(.collectionsError(.unexpectedError)))
                    }
                }
            }
        }
    }
    
    func createCollection(collectionName: String, completion: @escaping (Result<CollectionModel, AppError>) -> Void) {
        let url = baseURL + "/collections"
        let httpsParameters = [
            "name": collectionName
        ]
        AF.request(url, method: .post, parameters: httpsParameters, encoder: JSONParameterEncoder.default, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Create collection Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(CollectionModel.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.collectionsError(.modelError)))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 400:
                        completion(.failure(.collectionsError(.somethingWentWrong)))
                    case 401:
                        completion(.failure(.collectionsError(.unauthorized)))
                    case 404:
                        completion(.failure(.collectionsError(.wrongEndpoint)))
                    case 500:
                        completion(.failure(.collectionsError(.wrongEndpoint)))
                    default:
                        completion(.failure(.collectionsError(.unexpectedError)))
                    }
                }
            }
        }
    }
    
    func deleteCollection(completion: @escaping (Result<Bool, AppError>) -> Void) {
        
    }
    
    func addToCollection(collectionId: String, movieId: String, completion: @escaping (Result<Bool, AppError>) -> Void) {
        let url = baseURL + "/collections/\(collectionId)/movies"
        let httpParameters = [
            "movieId": movieId
        ]
        AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Add to collection Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 400:
                        completion(.failure(.collectionsError(.somethingWentWrong)))
                    case 401:
                        completion(.failure(.collectionsError(.unauthorized)))
                    case 404:
                        completion(.failure(.collectionsError(.wrongEndpoint)))
                    case 422:
                        completion(.failure(.collectionsError(.wrongCollectionId)))
                    case 500:
                        completion(.failure(.collectionsError(.alreadyInThisCollection)))
                    default:
                        completion(.failure(.collectionsError(.unexpectedError)))
                    }
                }
            }
        }
    }
    
    func getMoviesFromCollection(collectionId: String, completion: @escaping (Result<[MovieModel], AppError>) -> Void) {
        let url = baseURL + "/collections/\(collectionId)/movies"
        AF.request(url, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Get movies from collection Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode([MovieModel].self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.collectionsError(.modelError)))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 401:
                        completion(.failure(.collectionsError(.unauthorized)))
                    case 404:
                        completion(.failure(.collectionsError(.wrongEndpoint)))
                    case 422:
                        completion(.failure(.collectionsError(.wrongCollectionId)))
                    case 500:
                        completion(.failure(.collectionsError(.serverError)))
                    default:
                        completion(.failure(.collectionsError(.unexpectedError)))
                    }
                }
            }
        }
    }
    
    enum CollectionsError: Error, LocalizedError, Identifiable {
        case somethingWentWrong
        case wrongEndpoint
        case modelError
        case serverError
        case unauthorized
        case unexpectedError
        case wrongCollectionId
        case alreadyInThisCollection
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
            case .wrongCollectionId:
                return NSLocalizedString("Provided collectionId is not valid. Please contact developer", comment: "")
            case .alreadyInThisCollection:
                return NSLocalizedString("This film is already in the collection", comment: "")
            }
        }
    }
    
    
}
