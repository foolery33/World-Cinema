//
//  GetDayAndMonthFromStringDate.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import Foundation

final class GetDayAndMonthFromStringDateUseCase {
    
    func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        
//        dateFormatter.locale = Locale.current
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM"
        let resultString = dateFormatter.string(from: date)
        
        if Calendar.current.isDateInToday(date) {
            return "Сегодня"
        } else {
            return resultString
        }
    }
    
}
