//
//  MovieRepository.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 30.03.2023.
//

import Foundation

protocol MovieRepository {
    
    func getMovies(queryParameter: String, completion: @escaping (Result<[MovieModel], AppError>) -> Void)
    
}
