//
//  AppError.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 24.03.2023.
//

import Foundation

enum ViewModelType {
    
    case auth
    case movie
    
}

enum AppError: Error, LocalizedError, Identifiable, Equatable {
    
    case authError(AuthViewModel.AuthError)
    case movieError(MovieViewModel.MovieError)
    
    var id: String {
        self.errorDescription
    }
    var errorDescription: String {
        switch self {
        case .authError(let error):
            return error.errorDescription
        case .movieError(let error):
            return error.errorDescription
        }
    }
    
}