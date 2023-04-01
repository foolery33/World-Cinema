//
//  ActivityIndicator.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 25.03.2023.
//

import UIKit
import SnapKit

class ActivityIndicator: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0.0
        setupBackground()
        setupIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var background: UIView = {
        let background = UIView()
        background.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return background
    }()
    private func setupBackground() {
        addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        return indicator
    }()
    private func setupIndicator() {
        addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    func startAnimating() {
        indicator.startAnimating()
        UIView.animate(withDuration: 0.15) {
            self.alpha = 1.0
        }
    }
    func stopAnimation() {
        indicator.stopAnimating()
        self.alpha = 0.0
        self.removeFromSuperview()
    }
    
}
