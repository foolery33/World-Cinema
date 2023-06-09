//
//  CollectionsRepository.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import Foundation

protocol CollectionsRepository {
    
    func getCollections(completion: @escaping (Result<[CollectionModel], AppError>) -> Void)
    func createCollection(collectionName: String, completion: @escaping(Result<CollectionModel, AppError>) -> Void)
    func deleteCollection(collectionId: String, completion: @escaping(Result<Bool, AppError>) -> Void)
    func addToCollection(collectionId: String, movieId: String, completion: @escaping (Result<Bool, AppError>) -> Void)
    func getMoviesFromCollection(collectionId: String, completion: @escaping (Result<[MovieModel], AppError>) -> Void)
}
