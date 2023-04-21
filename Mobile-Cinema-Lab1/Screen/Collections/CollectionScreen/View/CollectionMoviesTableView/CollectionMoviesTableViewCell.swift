//
//  CollectionMoviesTableViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 08.04.2023.
//

import UIKit
import SkeletonView

class CollectionMoviesTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHStackView()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.isSkeletonable = true
        self.contentView.isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(movie: MovieModel) {
        self.nextImage.tintColor = .nextButtonColor
        self.image.loadImageWithURL(movie.poster) {
//            self.hideSkeleton()
        }
        self.image.image = self.image.image?.resizeImage(newWidth: 56, newHeight: 80)
        self.movieName.text = movie.name
        self.movieDescription.text = movie.description
    }
    
    // MARK: - HStackView setup
    
    private lazy var hStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.axis = .horizontal
        myStackView.spacing = 16
        myStackView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupHStackView() {
        contentView.addSubview(hStackView)
        setupImageView()
        setupMovieInfoStack()
        setupNextImage()
        hStackView.snp.makeConstraints { make in
//            make.horizontalEdges.equalToSuperview()
            make.width.equalToSuperview()
//            make.height.equalTo(96)
        }
    }
    
    // MARK: Image setup
    
    private lazy var image: UIImageView = {
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 56, height: 80))
        myImageView.isSkeletonable = true
        myImageView.contentMode = .scaleAspectFit
        myImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return myImageView
    }()
    private func setupImageView() {
        hStackView.addArrangedSubview(image)
        image.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(56)
        }
    }
    
    // MARK: MovieInfoStack setup
    
    private lazy var movieInfoStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.axis = .vertical
        myStackView.distribution = .equalCentering
        return myStackView
    }()
    private func setupMovieInfoStack() {
        hStackView.addArrangedSubview(movieInfoStack)
        movieInfoStack.addArrangedSubview(movieName)
        movieInfoStack.addArrangedSubview(movieDescription)
    }
    
    private lazy var movieName: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 14, weight: .bold)
        myLabel.numberOfLines = 1
        myLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        myLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        myLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
//        myLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return myLabel
    }()
    
    private lazy var movieDescription: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 14, weight: .regular)
        myLabel.numberOfLines = 3
        myLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        myLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        myLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        myLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return myLabel
    }()
    
    // MARK: NextButton setup
    
    private lazy var nextImage: UIImageView = {
        let myImageView = UIImageView()
//        myImageView.isSkeletonable = true
        myImageView.tintColor = .skeletonViewColor
        myImageView.contentMode = .scaleAspectFit
        myImageView.image = UIImage(named: "ForwardArrow")
        myImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        myImageView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return myImageView
    }()
    private func setupNextImage() {
        hStackView.addArrangedSubview(nextImage)
    }
    
}

extension CollectionMoviesTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

