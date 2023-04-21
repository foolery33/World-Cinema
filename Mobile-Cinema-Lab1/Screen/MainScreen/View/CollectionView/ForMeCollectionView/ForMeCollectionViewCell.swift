//
//  ProfileCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 28.03.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class ForMeCollectionViewCell: UICollectionViewCell {
    private let posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.isSkeletonable = true
        self.contentView.isSkeletonable = true
        self.showAnimatedSkeleton(usingColor: UIColor(red: 33/255, green: 21/255, blue: 18/255, alpha: 1))
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

    func setup(with movie: MovieModel) {
//        posterImageView.image = UIImage(named: "InTrendFilmPoster")?.resizeImage(newWidth: 100, newHeight: 144)
        posterImageView.loadImageWithURL(movie.poster) {
            self.hideSkeleton()
        }
    }
}


extension ForMeCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
