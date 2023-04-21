//
//  EpisodeScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 02.04.2023.
//

import UIKit

class EpisodeScreenViewController: UIViewController {

    var viewModel: EpisodeScreenViewModel!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let myView = self.view as? EpisodeScreenView {
            if self.isMovingFromParent {
                myView.saveEpisodeTime()
            }
            myView.videoPlayerView.pause()
        }
    }
    
    override func loadView() {
        let episodeScreenView = EpisodeScreenView(viewModel: self.viewModel)
        episodeScreenView.getEpisodeTime()
        episodeScreenView.getCollectionsNames()
        view = episodeScreenView
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
        view.backgroundColor = R.color.backgroundColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
