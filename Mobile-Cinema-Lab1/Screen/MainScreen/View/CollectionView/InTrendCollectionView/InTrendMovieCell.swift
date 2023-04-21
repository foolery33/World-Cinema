//
//  ProfileCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 28.03.2023.
//

import UIKit
import SnapKit
import SkeletonView

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

final class InTrendMovieCell: UICollectionViewCell {
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSkeletonable = true
        self.contentView.isSkeletonable = true
        self.showAnimatedSkeleton(usingColor: R.color.skeletonViewColor() ?? UIColor.skeletonViewColor)
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
        posterImageView.loadImageWithURL(movie.poster) {
            self.hideSkeleton()
        }
    }
}

extension InTrendMovieCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
