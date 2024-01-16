//
//  GetChatDateIndiciesUseCase.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import Foundation

final class RecognizeChatCellsUseCase {
    
    func recognize(groupedMessages: inout [[MessageModel]]) -> [Int: Any] {
        var elementCounter = 0
        var result: [Int: Any] = [:]
        
        for dayIndex in 0..<groupedMessages.count {
            for messageIndex in 0..<groupedMessages[dayIndex].count {
                if(messageIndex == 0) {
                    result[elementCounter] = String(groupedMessages[dayIndex][messageIndex].creationDateTime.prefix(10))
                    elementCounter += 1
                }
                if(messageIndex + 1 < groupedMessages[dayIndex].count) {
                    if(groupedMessages[dayIndex][messageIndex].authorId == groupedMessages[dayIndex][messageIndex + 1].authorId) {
                        var message = groupedMessages[dayIndex][messageIndex] as MessageModel
                        result[elementCounter] = message
                    }
                    else {
                        result[elementCounter] = groupedMessages[dayIndex][messageIndex] as MessageModel
                    }
                }
                else {
                    result[elementCounter] = groupedMessages[dayIndex][messageIndex] as MessageModel
                }
                elementCounter += 1
            }
        }
        
        return result
    }
    
}
