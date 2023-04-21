//
//  IconCollectionViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 06.04.2023.
//

import UIKit

class IconSelectionCollectionViewCell: UICollectionViewCell {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupPosterImageView()
    }

    private func setupViews() {
        contentView.clipsToBounds = true
    }

    private func setupPosterImageView() {
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with iconName: String) {
        posterImageView.image = UIImage(named: iconName)
    }
}


extension IconSelectionCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
