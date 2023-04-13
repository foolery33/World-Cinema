//
//  AppError.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 24.03.2023.
//

import Foundation

enum AppError: Error, LocalizedError, Identifiable, Equatable {
    
    case authError(AuthRepositoryImplementation.AuthError)
    case movieError(MovieRepositoryImplementation.MovieError)
    case coverError(CoverRepositoryImplementation.CoverError)
    case profileError(ProfileRepositoryImplementation.ProfileError)
    case collectionsError(CollectionsRepositoryImplementation.CollectionsError)
    case episodesError(EpisodesRepositoryImplementation.EpisodesError)
    
    var id: String {
        self.errorDescription
    }
    var errorDescription: String {
        switch self {
        case .authError(let error):
            return error.errorDescription
        case .movieError(let error):
            return error.errorDescription
        case .coverError(let error):
            return error.errorDescription
        case .profileError(let error):
            return error.errorDescription
        case .collectionsError(let error):
            return error.errorDescription
        case .episodesError(let error):
            return error.errorDescription
        }
    }
    
}
