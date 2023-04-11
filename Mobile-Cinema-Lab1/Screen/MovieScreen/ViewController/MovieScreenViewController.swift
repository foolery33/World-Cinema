//
//  MovieScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 31.03.2023.
//

import UIKit

class MovieScreenViewController: UIViewController {

    var viewModel: MovieScreenViewModel!
    
    override func loadView() {
        let movieScreenView = MovieScreenView(viewModel: self.viewModel)
        view = movieScreenView
        movieScreenView.getEpisodes()
        print("MovieID", viewModel.movie.movieId)
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
