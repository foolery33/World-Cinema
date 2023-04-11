//
//  EpisodeScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 02.04.2023.
//

import UIKit

class EpisodeScreenViewController: UIViewController {

    var viewModel: EpisodeScreenViewModel!
    
    override func loadView() {
        let episodeScreenView = EpisodeScreenView(viewModel: self.viewModel)
        view = episodeScreenView
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
