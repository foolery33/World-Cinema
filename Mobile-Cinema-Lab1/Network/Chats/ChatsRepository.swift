//
//  ChatsRepository.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import Foundation

protocol ChatsRepository {
    
    func getChatList(completion: @escaping (Result<[ChatModel], AppError>) -> Void)
    
}
