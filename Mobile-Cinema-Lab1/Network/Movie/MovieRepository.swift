//
//  MovieRepository.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 30.03.2023.
//

import Foundation

protocol MovieRepository {
    
    func getMovies(queryParameter: String, completion: @escaping (Result<[MovieModel], AppError>) -> Void)
    func getMovieEpisodesById(movieId: String, completion: @escaping (Result<[EpisodeModel], AppError>) -> Void)
    func dislikeMovie(movieId: String, completion: @escaping (Result<Bool, AppError>) -> Void)
    
}
