//
//  MainScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 25.03.2023.
//

import Foundation

class MainScreenViewModel {
    
    weak var coordinator: MainCoordinator!
    
    lazy var inTrendMoviesViewModel = InTrendMoviesViewModel(movieRepository: MovieRepositoryImplementation())
    lazy var lastViewMoviesViewModel = LastViewMoviesViewModel(movieRepository: MovieRepositoryImplementation())
    lazy var newMoviesViewModel = NewMoviesViewModel(movieRepository: MovieRepositoryImplementation())
    lazy var forMeMoviesViewModel = ForMeMoviesViewModel(movieRepository: MovieRepositoryImplementation())
    
}
