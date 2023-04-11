//
//  IconSelectionScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 06.04.2023.
//

import UIKit

class IconSelectionScreenViewController: UIViewController {

    var viewModel: IconSelectionScreenViewModel
    var delegate: ChooseIconDelegate
    
    init(viewModel: IconSelectionScreenViewModel, delegate: ChooseIconDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let iconSelectionScreenView = IconSelectionScreenView(viewModel: self.viewModel)
        view = iconSelectionScreenView
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
