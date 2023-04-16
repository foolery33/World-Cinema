//
//  EpisodesRepository.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 12.04.2023.
//

import Foundation

protocol EpisodesRepository {
    
    func getEpisodeComments(episodeId: String, completion: @escaping (Result<[CommentModel], AppError>) -> Void)
    func postEpisodeComment(episodeId: String, completion: @escaping (Result<[CommentModel], AppError>) -> Void)
    func getEpisodeTime(episodeId: String, completion: @escaping (Result<EpisodeTimeModel, AppError>) -> Void)
    func saveEpisodeTime(episodeId: String, timeInSeconds: Int, completion: @escaping (Result<Bool, AppError>) -> Void)
    
}
