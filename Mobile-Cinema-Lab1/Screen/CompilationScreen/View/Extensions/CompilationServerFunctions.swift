//
//  ServerFunctions.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 11.04.2023.
//

import Foundation

extension CompilationScreenView {
    func loadCompilationMovies() {
        self.setupActivityIndicator()
        DispatchQueue.global(qos: .userInteractive).async {
            self.viewModel.getCompilaiton { success in
                self.stopActivityIndicator()
                if success {
                    if self.viewModel.movies.isEmpty {
                        self.showEmptyScreen()
                    }
                    else {
                        if self.viewModel.movies.count > 1 {
                            self.setupImages()
                        }
                        else {
                            self.setupImage()
                        }
                        self.currentMovieIndex += 1
                    }
                }
                else {
                    self.showAlert(title: "Movies Loading Error", message: self.viewModel.error)
                }
            }
        }
    }
    
    @objc func dislikeMovie() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.viewModel.dislikeMovie(movieId: self.viewModel.movies[self.currentMovieIndex - 1].movieId) { success in
                if !success {
                    self.showAlert(title: "Movie Dislike Error", message: self.viewModel.error)
                }
            }
        }
    }
    
    @objc func addToFavourites() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.addToFavourites(collectionId: UserDataManager.shared.fetchFavouritesCollectionId(), movieId: self.viewModel.movies[self.currentMovieIndex - 1].movieId) { success in
                if !success {
                    self.showAlert(title: "Movie Like Error", message: self.viewModel.error)
                }
            }
        }
    }
}
