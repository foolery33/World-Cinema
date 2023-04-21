//
//  IconSelectionScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 06.04.2023.
//

import UIKit

class IconSelectionScreenViewController: UIViewController {

    var delegate: ChooseIconDelegate
    
    init(delegate: ChooseIconDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let iconSelectionScreenView = IconSelectionScreenView()
        view = iconSelectionScreenView
        view.backgroundColor = R.color.backgroundColor()
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
