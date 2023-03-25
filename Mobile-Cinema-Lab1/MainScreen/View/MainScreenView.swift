//
//  MainScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 25.03.2023.
//

import UIKit
import SnapKit

class MainScreenView: UIView {

    var viewModel: MainScreenViewModel
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupPoster()
    }
    
    private lazy var poster: UIImageView = {
        let poster = UIImageView()
        poster.image = UIImage(named: "TheMagicians")
        return poster
    }()
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.85)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = poster.bounds
        poster.layer.addSublayer(gradient)
    }
    private func setupPoster() {
        addSubview(poster)
        poster.snp.makeConstraints { make in
            make.top.equalTo(safeAreaInsets.top)
            make.leading.trailing.equalToSuperview()
        }
    }

}
