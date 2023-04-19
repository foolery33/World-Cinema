//
//  EpisodesServerFunctions.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import Foundation
import AVKit

extension EpisodeScreenView {
    
    func saveEpisodeTime() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.saveEpisodeTime(episodeId: self.viewModel.episode.episodeId, timeInSeconds: Int(self.videoPlayerView.videoPlayer.currentTime().seconds)) { success in
                if !success {
                    self.showAlert(title: "Saving Episode Time Error", message: self.viewModel.error)
                }
            }
        }
    }
    
    func getEpisodeTime() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.viewModel.getEpisodeTime(episodeId: self.viewModel.episode.episodeId) { success in
                if success {
                    self.videoPlayerView.videoSlider.value = Float(self.viewModel.episodeTime.timeInSeconds ?? 0)
                    self.videoPlayerView.videoPlayer.seek(to: CMTime(seconds: Double(self.viewModel.episodeTime.timeInSeconds ?? 0), preferredTimescale: 1))
                }
                else {
                    self.showAlert(title: "Loading Episode Time Error", message: self.viewModel.error)
                }
            }
        }
    }
    
}
