//
//  HistoryRepository.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 21.04.2023.
//

import Foundation

protocol HistoryRepository {
    
    func getHistory(completion: @escaping (Result<[EpisodeViewModel], AppError>) -> Void)
    
}
