//
//  GetGenresListFromTagsUseCase.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 31.03.2023.
//

import Foundation

class GetGenresListFromTagsUseCase {
    
    func getList(_ tags: [TagModel]) -> [String] {
        return tags.map { $0.tagName }
    }
    
}
