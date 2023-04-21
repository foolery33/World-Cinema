//
//  EpisodesTableViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 01.04.2023.
//

import UIKit
import SnapKit
import SkeletonView

class EpisodesTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHStackView()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.isSkeletonable = true
        self.contentView.isSkeletonable = true
    }
    
    func setup(with episode: EpisodeModel, isLast: Bool) {
        descriptionStackView.distribution = .equalSpacing
        image.loadImageWithURL(episode.preview)
        episodeNameLabel.text = episode.name
        episodeDescription.text = episode.description
        episodeYear.text = String(episode.year)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        // do nothing to remove the gray selection effect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    
    private let hStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.axis = .horizontal
        myStackView.spacing = 16
        return myStackView
    }()
    private func setupHStackView() {
        contentView.addSubview(hStackView)
        setupImage()
        setupDescriptionStackView()
        hStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private let image: UIImageView = {
        let myImage = UIImageView()
        myImage.isSkeletonable = true
        myImage.contentMode = .scaleAspectFill
        myImage.clipsToBounds = true
        return myImage
    }()

    private func setupImage() {
        hStackView.addArrangedSubview(image)
        image.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(128)
        }
    }

    private let descriptionStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.axis = .vertical
        myStackView.spacing = 10
//        myStackView.spacing = 12
        return myStackView
    }()
    private func setupDescriptionStackView() {
        hStackView.addArrangedSubview(descriptionStackView)
        setupEpisodeNameLabel()
        setupDescriptionAndYearStackView()
        descriptionStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
    }
    
    private let descriptionAndYearStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.axis = .vertical
//        myStackView.distribution = .equalSpacing
        return myStackView
    }()
    private func setupDescriptionAndYearStackView() {
        descriptionStackView.addArrangedSubview(descriptionAndYearStackView)
        setupEpisodeDescription()
        setupEpisodeYear()
    }
    
    private let episodeNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
        myLabel.skeletonTextLineHeight = .relativeToFont
        myLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        myLabel.numberOfLines = 1
        myLabel.textColor = .white
        myLabel.sizeToFit()
        return myLabel
    }()
    private func setupEpisodeNameLabel() {
        descriptionStackView.addArrangedSubview(episodeNameLabel)
    }
    
    private let episodeDescription: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
        myLabel.skeletonTextLineHeight = .relativeToFont
        myLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        myLabel.numberOfLines = 2
        myLabel.textColor = .grayTextColor
        return myLabel
    }()
    private func setupEpisodeDescription() {
        descriptionAndYearStackView.addArrangedSubview(episodeDescription)
    }
    
    private let episodeYear: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
        myLabel.skeletonTextLineHeight = .relativeToFont
        myLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        myLabel.numberOfLines = 1
        myLabel.textColor = .grayTextColor
        return myLabel
    }()
    private func setupEpisodeYear() {
        descriptionAndYearStackView.addArrangedSubview(episodeYear)
    }
    
    private func setupViews() {
        contentView.clipsToBounds = true
    }
}


extension EpisodesTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
