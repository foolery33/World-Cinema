//
//  CompilationCardView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 11.04.2023.
//

import UIKit
import SnapKit

class CompilationCardView: UIView {

    init() {
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupCardImageView()
    }
    
    // MARK: - CardImageView setup
    
    lazy var cardImageView: UIImageView = {
        let myImageView = UIImageView()
//        myImageView.image = UIImage(named: "WitcherPoster")?.resizeImage(newWidth: 327, newHeight: 486)
        myImageView.contentMode = .scaleAspectFill
        myImageView.layer.cornerRadius = 16
        myImageView.layer.masksToBounds = true
        myImageView.isUserInteractionEnabled = true
        return myImageView
    }()
    private func setupCardImageView() {
        addSubview(cardImageView)
        setupUserReactionImageView()
        cardImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(486)
            make.width.equalTo(327)
        }
    }
    
    // MARK: UserReactionImageView setup
    
    lazy var userReactionImageView: UIImageView = {
        let myImageView = UIImageView(image: UIImage())
        myImageView.alpha = 0
        myImageView.contentMode = .scaleAspectFill
        return myImageView
    }()
    private func setupUserReactionImageView() {
        cardImageView.addSubview(userReactionImageView)
        userReactionImageView.snp.makeConstraints { make in
            make.height.width.equalTo(90)
            make.center.equalToSuperview()
        }
    }

}
