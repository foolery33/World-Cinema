//
//  ProfileCell.swift
//  UICollectionViewDemo
//
//  Created by Jayesh Kawli on 12/21/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//
import UIKit

final class ProfileCell: UICollectionViewCell {

    private let posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        print("cell init")
        setupViews()
        setupPosterImageView()
    }

    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
    }

    private func setupPosterImageView() {
        print("setup poster")
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with movie: MovieModel) {
        print("setup")
        posterImageView.image = UIImage(named: "InTrendFilmPoster")?.resizeImage(newWidth: 100, newHeight: 144)
    }
}


extension ProfileCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
