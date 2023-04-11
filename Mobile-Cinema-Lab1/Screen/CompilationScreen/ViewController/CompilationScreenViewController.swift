//
//  CompilationScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 10.04.2023.
//

import UIKit

class CompilationScreenViewController: UIViewController {

    var viewModel: CompilationScreenViewModel!
    
    override func loadView() {
        let compilationScreenView = CompilationScreenView(viewModel: self.viewModel)
        view = compilationScreenView
        compilationScreenView.loadCompilationMovies()
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
