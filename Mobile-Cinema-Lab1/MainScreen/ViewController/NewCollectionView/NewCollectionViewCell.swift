//
//  NewCollectionViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 28.03.2023.
//

import UIKit

final class NewCollectionViewCell: UICollectionViewCell {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }

    private func setupViews() {
        print("here")
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
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

    func setup(with movie: MovieModel) {
        posterImageView.image = UIImage(named: "NewFilmPoster")
    }
}

extension NewCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
