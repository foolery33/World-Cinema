//
//  MovieScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 31.03.2023.
//

import UIKit
import SnapKit

class MovieScreenView: UIView {
    
    var viewModel: MovieScreenViewModel
    
    init(viewModel: MovieScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupScrollView()
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
        let myContentView = UIView()
        return myContentView
    }()
    private func setupContentView() {
        scrollView.addSubview(contentView)
        setupPoster()
        setupWatchPosterButton()
        setupUnderPosterStack()
        setupStackView()
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - Poster setup
    
    private lazy var poster: UIImageView = {
        let myImageView = UIImageView()
        myImageView.loadImageWithURL(viewModel.movie.poster)
        myImageView.clipsToBounds = true
        return myImageView
    }()
    private lazy var gradient: CAGradientLayer = {
        let myGradient = CAGradientLayer()
        myGradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        myGradient.startPoint = CGPoint(x: 0, y: 0.7)
        myGradient.endPoint = CGPoint(x: 0, y: 1)
        return myGradient
    }()
    override func layoutSubviews() {
        gradient.frame = poster.bounds
        poster.layer.addSublayer(gradient)
    }
    private func setupPoster() {
        let topInset = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0.0
        contentView.addSubview(poster)
        poster.snp.makeConstraints { make in
            make.width.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(-topInset)
            make.height.equalTo(400)
        }
    }
    
    // MARK: Watch poster button setup
    
    private lazy var watchPosterButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setTitle("Смотреть", for: .normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        myButton.setTitleColor(.white, for: .normal)
        myButton.contentEdgeInsets = UIEdgeInsets(top: 13, left: 32, bottom: 13, right: 32)
        myButton.backgroundColor = .redColor
        myButton.layer.cornerRadius = 4
        return myButton
    }()
    private func setupWatchPosterButton() {
        contentView.addSubview(watchPosterButton)
        watchPosterButton.snp.makeConstraints { make in
            make.bottom.equalTo(poster.snp.bottom).inset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - UnderPosterStack setup
    
    private lazy var underPosterStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 16
        return myStackView
    }()
    private func setupUnderPosterStack() {
        contentView.addSubview(underPosterStack)
        setupAgeLimit()
        setupChatButton()
        underPosterStack.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: Age limit setup
    
    private lazy var ageLimit: UILabel = {
        return GetAgeLimitLabelUseCase().getLabel(ageLimit: viewModel.movie.age)
    }()
    private func setupAgeLimit() {
        underPosterStack.addArrangedSubview(ageLimit)
    }
    
    // MARK: ChatButton setup
    
    private lazy var chatButton: UIButton = {
        let myButton = UIButton(type: .custom)
        myButton.setImage(UIImage(named: "Chat"), for: .normal)
        return myButton
    }()
    private func setupChatButton() {
        underPosterStack.addArrangedSubview(chatButton)
    }
    
    // MARK: - StackView setup
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 32
        return stackView
    }()
    private func setupStackView() {
        contentView.addSubview(stackView)
        setupGenresCollectionView()
        setupDescriptionStackView()
        setupShotsStackView()
        setupEpisodesStackView()
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(underPosterStack.snp.bottom).offset(32)
        }
    }
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "asdasdasdasd"
        label.textColor = .red
        return label
    }()
    
    // MARK: GenresCollectionView setup
    
    private lazy var genresCollectionView: GenresCollectionView = {
        let myCollectionView = GenresCollectionView()
        myCollectionView.genres = GetGenresListFromTagsUseCase().getList(viewModel.movie.tags)
        return myCollectionView
    }()
    private func setupGenresCollectionView() {
        stackView.addArrangedSubview(genresCollectionView)
        genresCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
//            make.height.equalTo(genresCollectionView.collectionViewLayout.collectionViewContentSize.height)
            make.height.equalTo(genresCollectionView.calculateContentHeight())
        }
        print(genresCollectionView.contentSize)
        print(genresCollectionView.numberOfSections)
//        stackView.addArrangedSubview(label)
//        genresCollectionView.reloadData()
    }
    
    // MARK: - Description StackView setup
    
    private lazy var descriptionStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 8
        return myStackView
    }()
    private func setupDescriptionStackView() {
        stackView.addArrangedSubview(descriptionStackView)
        setupDescriptionSectionLabel()
        setupDescriptionLabel()
        descriptionStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: Description section label setup
    
    private lazy var descriptionSectionLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Описание"
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 24, weight: .bold)
        return myLabel
    }()
    private func setupDescriptionSectionLabel() {
        descriptionStackView.addArrangedSubview(descriptionSectionLabel)
        descriptionSectionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
    }
    
    // MARK: Description label setup
    
    private lazy var descriptionLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = viewModel.movie.description
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 14, weight: .regular)
        myLabel.numberOfLines = 0
        return myLabel
    }()
    private func setupDescriptionLabel() {
        descriptionStackView.addArrangedSubview(descriptionLabel)
        descriptionSectionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
    }
    
    // MARK: - Shots StackView setup
    
    private lazy var shotsStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 16
        return myStackView
    }()
    private func setupShotsStackView() {
        stackView.addArrangedSubview(shotsStackView)
        setupShotsLabel()
        setupShotsCollectionView()
        shotsStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(72 + shotsStackView.spacing + shotsLabel.frame.size.height)
        }
    }
    
    // MARK: Shots label setup
    
    private lazy var shotsLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Кадры"
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 24, weight: .bold)
        myLabel.sizeToFit()
        return myLabel
    }()
    private func setupShotsLabel() {
        shotsStackView.addArrangedSubview(shotsLabel)
        shotsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    // MARK: ShotsCollectionView setup
    
    private lazy var shotsCollectionView: ShotsCollectionView = {
        let myCollectionView = ShotsCollectionView()
        myCollectionView.images = viewModel.movie.imageUrls
        return myCollectionView
    }()
    private func setupShotsCollectionView() {
        shotsStackView.addArrangedSubview(shotsCollectionView)
        shotsCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Episodes StackView setup
    
    private lazy var episodesStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 16
        return myStackView
    }()
    private func setupEpisodesStackView() {
        stackView.addArrangedSubview(episodesStackView)
        setupEpisodesLabel()
        setupEpisodesTableView()
        episodesStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: Episodes label setup
    
    private lazy var episodesLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Эпизоды"
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 24, weight: .bold)
        return myLabel
    }()
    private func setupEpisodesLabel() {
        episodesStackView.addArrangedSubview(episodesLabel)
        episodesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
    }
    
    private lazy var episodesTablveView: EpisodesTableView = {
        let myTableView = EpisodesTableView()
        myTableView.viewModel = self.viewModel
        return myTableView
    }()
    private func setupEpisodesTableView() {
        episodesStackView.addArrangedSubview(episodesTablveView)
        episodesTablveView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(episodesTablveView.countHeight())
        }
    }
    private func reloadEpisodesView() {
        if(self.viewModel.episodes.isEmpty) {
            episodesStackView.removeFromSuperview()
            ()
        }
        else {
            episodesTablveView.reloadData()
        }
    }
    
    
    func getEpisodes() {
        let activityIndicator = ActivityIndicator()
        addSubview(activityIndicator)
        activityIndicator.setupAnimation()
        viewModel.getMovieEpisodesById(movieId: viewModel.movie.movieId) { success in
            activityIndicator.stopAnimation()
            if(success) {
                self.episodesTablveView.snp.remakeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(self.episodesTablveView.countHeight())
                    print("newHeight", self.episodesTablveView.countHeight())
                }
                self.reloadEpisodesView()
                
            }
            else {
                self.showAlert(title: "Episodes loading error", message: self.viewModel.error)
            }
        }
    }
    
}
