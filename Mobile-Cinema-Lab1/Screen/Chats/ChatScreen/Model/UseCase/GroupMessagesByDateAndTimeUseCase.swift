//
//  GroupMessagesByDateAndTimeUseCase.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import Foundation

final class GroupMessagesByDateAndTimeUseCase {
    
    func groupMessagesByDate(messages: [MessageModel]) -> [[MessageModel]] {
        let sortedMessages = messages.sorted { $0.creationDateTime < $1.creationDateTime }
        let messageGroups = sortedMessages.reduce(into: [[MessageModel]]()) { (result, message) in
            guard let index = result.firstIndex(where: { $0.first?.creationDateTime.starts(with: message.creationDateTime.prefix(10)) == true }) else {
                result.append([message])
                return
            }
            result[index].append(message)
        }
        let ans = messageGroups.map { $0.sorted { $0.creationDateTime < $1.creationDateTime } }
        
        return ans
        
    }
    
}
