//
//  CollectionsRepository.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import Foundation

protocol CollectionsRepository {
    
    func getCollections(completion: @escaping (Result<[CollectionModel], AppError>) -> Void)
    func createCollection(completion: @escaping(Result<Bool, AppError>) -> Void)
    func deleteCollection(completion: @escaping(Result<Bool, AppError>) -> Void)
    
}
