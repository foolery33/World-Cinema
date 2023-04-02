//
//  CoverRepository.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 02.04.2023.
//

import Foundation

protocol CoverRepository {
    func getCover(completion: @escaping (Result<CoverModel, AppError>) -> Void)
}
