//
//  IsoTimeToHHMMUseCase.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import Foundation

final class IsoTimeToHHMMUseCase {
    
    func convertToTime(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
}
