//
//  MainScreenServerFunctions.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 22.04.2023.
//

import Foundation

extension MainScreenView {
    
    func loadCover() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.getCover { success in
                if(success) {
                    self.poster.loadImageWithURL(self.viewModel.cover.backgroundImage) {
                        self.poster.hideSkeleton()
                    }
                }
                else {
                    self.showAlert(title: R.string.mainScreenStrings.cover_loading_failed(), message: self.viewModel.error)
                }
            }
        }
    }
    
    func loadSections() {
        self.setupSkeleton()
        // Создание глобальной очереди для выполнения задач
        let queue = DispatchQueue.global(qos: .userInteractive)

        // Помещение задач в очередь
        queue.async {
            self.viewModel.inTrendMoviesViewModel.getInTrendMovies { success in
                if(success) {
                    self.reloadInTrendMoviesView()
                }
                else {
                    self.showAlert(title: R.string.mainScreenStrings.movies_loading_failed(), message: self.viewModel.inTrendMoviesViewModel.error)
                }
            }
        }

        queue.async {
            self.viewModel.lastViewMoviesViewModel.getLastViewMovies { success in
                if success {
                    self.viewModel.lastViewMoviesViewModel.getHistory { newSuccess in
                        if(newSuccess) {
                            self.reloadLastViewMoviesView()
                        }
                        else {
                            self.showAlert(title: R.string.mainScreenStrings.history_loading_failed(), message: self.viewModel.lastViewMoviesViewModel.error)
                        }
                    }
                }
                else {
                    self.showAlert(title: R.string.mainScreenStrings.movies_loading_failed(), message: self.viewModel.lastViewMoviesViewModel.error)
                }
            }
        }

        queue.async {
            self.viewModel.newMoviesViewModel.getNewMovies { success in
                if(success) {
                    self.reloadNewMoviesView()
                }
                else {
                    self.showAlert(title: R.string.mainScreenStrings.movies_loading_failed(), message: self.viewModel.newMoviesViewModel.error)
                }
            }
        }

        queue.async {
            self.viewModel.forMeMoviesViewModel.getForMeMovies { success in
                if(success) {
                    self.reloadForYouMoviesView()
                }
                else {
                    self.showAlert(title: R.string.mainScreenStrings.movies_loading_failed(), message: self.viewModel.forMeMoviesViewModel.error)
                }
                self.stopSkeleton()
            }
        }
    }
    
}
