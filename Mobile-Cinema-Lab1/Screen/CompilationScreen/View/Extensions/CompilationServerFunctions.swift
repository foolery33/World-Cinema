//
//  ServerFunctions.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 11.04.2023.
//

import Foundation
import SkeletonView

extension CompilationScreenView {
    func loadCompilationMovies() {
        self.setupSkeleton()
        DispatchQueue.global(qos: .userInteractive).async {
            self.viewModel.getCompilaiton { success in
                if success {
                    self.getFavouriteCollection { newSuccess in
                        self.stopSkeleton()
                        if newSuccess {
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
                            self.showAlert(title: R.string.compilationScreenStrings.movie_like_error(), message: self.viewModel.error)
                        }
                    }
                }
                else {
                    self.stopSkeleton()
                    self.showAlert(title: R.string.compilationScreenStrings.movies_loading_error(), message: self.viewModel.error)
                }
            }
        }
    }
    
    @objc func dislikeMovie() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.viewModel.dislikeMovie(movieId: self.viewModel.movies[self.currentMovieIndex - 1].movieId) { success in
                if !success {
                    self.showAlert(title: R.string.compilationScreenStrings.movie_dislike_error(), message: self.viewModel.error)
                }
            }
        }
    }
    
    @objc func addToFavourites() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.addToFavourites(collectionId: UserDataManager.shared.fetchFavouritesCollectionId(), movieId: self.viewModel.movies[self.currentMovieIndex - 1].movieId) { success in
                if !success {
                    self.showAlert(title: R.string.compilationScreenStrings.movie_like_error(), message: self.viewModel.error)
                }
            }
        }
    }
    
    @objc func getFavouriteCollection(completion: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.getFavouriteCollection { success in
                return completion(success)
            }
        }
    }
}
