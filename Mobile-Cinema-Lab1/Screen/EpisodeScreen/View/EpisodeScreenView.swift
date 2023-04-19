//
//  EpisodeScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 02.04.2023.
//

import UIKit
import SnapKit
import AVKit
import AVFoundation

class EpisodeScreenView: UIView {
    
    var viewModel: EpisodeScreenViewModel
    
    init(viewModel: EpisodeScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupScrollView()
        setupBackButton()
    }
    
    // MARK: - ScrollView setup
    
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.showsVerticalScrollIndicator = false
        return myScrollView
    }()
    private func setupScrollView() {
        addSubview(scrollView)
        setupContentView()
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - ContentView setup
    
    private lazy var contentView: UIView = {
        let myView = UIView()
        return myView
    }()
    private func setupContentView() {
        scrollView.addSubview(contentView)
        setupVideoPlayerView()
        setupEpisodeLabel()
        setupUnderNameStack()
        setupDescriptionStack()
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

    // MARK: - VideoPlayerView setup
    
    lazy var videoPlayerView: VideoPlayerView = {
        let myView = VideoPlayerView(filePath: self.viewModel.episode.filePath, startValue: self.viewModel.episodeTime.timeInSeconds ?? 0, duration: self.viewModel.episode.runtime, frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 210))
        return myView
    }()
    private func setupVideoPlayerView() {
        contentView.addSubview(videoPlayerView)
        videoPlayerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(210)
        }
    }
    
    // MARK: Back button
    
    private lazy var backButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setImage(UIImage(named: "BackArrow"), for: .normal)
        myButton.tintColor = .white
        myButton.addTarget(self, action: #selector(backToMainScreen), for: .touchUpInside)
        myButton.contentEdgeInsets = UIEdgeInsets(top: 11.5, left: 6.5, bottom: 14, right: 14)
        return myButton
    }()
    private func setupBackButton() {
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }
    @objc private func backToMainScreen() {
        viewModel.backToMovieScreen()
    }
    
    // MARK: - Episode label setup
    
    private lazy var episodeLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = viewModel.episode.name
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 24, weight: .bold)
        myLabel.numberOfLines = 0
        return myLabel
    }()
    private func setupEpisodeLabel() {
        contentView.addSubview(episodeLabel)
        episodeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(videoPlayerView.snp.bottom).offset(16)
        }
    }
    
    // MARK: - Under name StackView setup
    private lazy var underNameStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.distribution = .equalSpacing
//        myStackView.spacing = 16
        return myStackView
    }()
    private func setupUnderNameStack() {
        contentView.addSubview(underNameStack)
        setupMovieInfoStack()
        setupIconsStackView()
        underNameStack.snp.makeConstraints { make in
            make.top.equalTo(episodeLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Movie info StackView setup
    
    private lazy var movieInfoStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis =  .horizontal
        myStackView.spacing = 16
        return myStackView
    }()
    private func setupMovieInfoStack() {
        underNameStack.addArrangedSubview(movieInfoStack)
        setupPoster()
        setupMovieDescriptionStack()
    }
    // MARK: Poster setup
    private lazy var poster: UIImageView = {
        let myImageView = UIImageView()
        return myImageView
    }()
    private func setupPoster() {
        movieInfoStack.addArrangedSubview(poster)
        poster.loadImageWithURL(viewModel.movie.poster)
        poster.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(64)
        }
    }
    // MARK: Movie description StackView setup
    private lazy var movieDescriptionStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.distribution = .fillEqually
        return myStackView
    }()
    private func setupMovieDescriptionStack() {
        movieInfoStack.addArrangedSubview(movieDescriptionStack)

        movieDescriptionStack.addArrangedSubview(movieNameLabel)
        movieDescriptionStack.addArrangedSubview(seasonsLabel)
        movieDescriptionStack.addArrangedSubview(yearsLabel)
        movieDescriptionStack.snp.makeConstraints { make in
            make.width.equalTo(150)
        }
    }
    // MARK: Movie name label setup
    private lazy var movieNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = viewModel.movie.name
        myLabel.numberOfLines = 1
        myLabel.font = .systemFont(ofSize: 12, weight: .bold)
        myLabel.textColor = .white
        myLabel.sizeToFit()
        return myLabel
    }()
    // MARK: Seasons label setup
    private lazy var seasonsLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Unknown сезонов"
        myLabel.numberOfLines = 1
        myLabel.font = .systemFont(ofSize: 12, weight: .regular)
        myLabel.textColor = .grayTextColor
        myLabel.sizeToFit()
        myLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return myLabel
    }()
    // MARK: Years label setup
    private lazy var yearsLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = viewModel.yearRange
        myLabel.numberOfLines = 1
        myLabel.font = .systemFont(ofSize: 12, weight: .regular)
        myLabel.textColor = .grayTextColor
        myLabel.sizeToFit()
        return myLabel
    }()
    
    // MARK: - Icons StackView setup
    private lazy var iconsStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.spacing = 22
        myStackView.axis = .horizontal
        return myStackView
    }()
    private func setupIconsStackView() {
        underNameStack.addArrangedSubview(iconsStackView)
        
        iconsStackView.addArrangedSubview(chatButton)
        iconsStackView.addArrangedSubview(plusButton)
        iconsStackView.addArrangedSubview(favouriteButton)
    }
    // MARK: Chat button setup
    private lazy var chatButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setImage(UIImage(named: "Chat"), for: .normal)
        myButton.tintColor = .redColor
        return myButton
    }()
    // MARK: Plus button setup
    private lazy var plusButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setImage(UIImage(named: "Plus"), for: .normal)
        myButton.tintColor = .redColor
        myButton.addTarget(self, action: #selector(self.showAddToCollectionActionSheet), for: .touchUpInside)
        return myButton
    }()
    // MARK: Heart button setup
    private lazy var favouriteButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setImage(UIImage(named: "Heart"), for: .normal)
        myButton.tintColor = .redColor
        return myButton
    }()
    
    // MARK: Description StackView setup
    
    private lazy var descriptionStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 8
        return myStackView
    }()
    private func setupDescriptionStack() {
        contentView.addSubview(descriptionStack)
        descriptionStack.addArrangedSubview(descriptionSectionLabel)
        descriptionStack.addArrangedSubview(descriptionLabel)
        descriptionStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-28)
            make.top.equalTo(underNameStack.snp.bottom).offset(32)
        }
    }
    
    // MARK: DescriptionSection label setup
    private lazy var descriptionSectionLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 1
        myLabel.text = "Описание"
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 24, weight: .bold)
        return myLabel
    }()
    // MARK: Description label setup
    private lazy var descriptionLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 0
        myLabel.text = viewModel.episode.description
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 14, weight: .regular)
        return myLabel
    }()
}

extension EpisodeScreenView {
    @objc func showAddToCollectionActionSheet() {
        let collectionNames = viewModel.getCollectionsList()
        
        let alert = UIAlertController(title: "Добавить в коллекцию", message: nil, preferredStyle: .actionSheet)
        
        for collection in collectionNames {
            alert.addAction(UIAlertAction(title: collection.name, style: .default, handler: {_ in
                self.setupActivityIndicator()
                self.viewModel.addToCollection(collectionId: collection.id, movieId: self.viewModel.movie.movieId) { success in
                    self.stopActivityIndicator()
                    if(success) {
                        self.showAlert(title: "Success", message: "You've successfully added the movie to the colleciton \(collection.name)")
                    }
                    else {
                        self.showAlert(title: "Adding to collection error", message: self.viewModel.error)
                        return
                    }
                }
            }))
        }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        if let viewController = self.next as? UIViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
