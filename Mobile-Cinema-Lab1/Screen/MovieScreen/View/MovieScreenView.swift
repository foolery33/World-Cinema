//
//  MovieScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 31.03.2023.
//

import UIKit
import SnapKit
import SkeletonView

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
        myGradient.startPoint = Constants.gradientStartPoint
        myGradient.endPoint = Constants.gradientEndPoint
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
            make.height.equalTo(Scales.posterHeight)
        }
    }
    
    // MARK: Back button
    
    private lazy var backButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setImage(R.image.backArrow(), for: .normal)
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
        viewModel.backToMainScreen()
    }
    
    // MARK: Watch poster button setup
    
    private lazy var watchPosterButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setTitle(R.string.movieScreenStrings.watch(), for: .normal)
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
        myButton.setImage(R.image.chat(), for: .normal)
        myButton.addTarget(self, action: #selector(goToChatScreen), for: .touchUpInside)
        return myButton
    }()
    private func setupChatButton() {
        underPosterStack.addArrangedSubview(chatButton)
    }
    @objc private func goToChatScreen() {
        self.viewModel.goToChatScreen(chat: self.viewModel.movie.chatInfo)
    }
    
    // MARK: - StackView setup
    
    private lazy var stackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 32
        return myStackView
    }()
    private func setupStackView() {
        contentView.addSubview(stackView)
        setupGenresCollectionStack()
        setupDescriptionStackView()
        setupShotsStackView()
        setupEpisodesStackView()
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(underPosterStack.snp.bottom).offset(32)
        }
    }
    
    // MARK: - GenresCollection StackView setup
    
    private lazy var genresCollectionStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 32
        myStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupGenresCollectionStack() {
        stackView.addArrangedSubview(genresCollectionStack)
        genresCollectionStack.addArrangedSubview(genresCollectionView)
        genresCollectionView.snp.makeConstraints { make in
            make.height.equalTo(genresCollectionView.calculateContentHeight())
        }
    }
    
    // MARK: GenresCollectionView setup
    
    private lazy var genresCollectionView: GenresCollectionView = {
        let myCollectionView = GenresCollectionView()
        myCollectionView.genres = GetGenresListFromTagsUseCase().getList(viewModel.movie.tags)
        return myCollectionView
    }()
    
    // MARK: - Description StackView setup
    
    private lazy var descriptionStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 8
        myStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupDescriptionStackView() {
        stackView.addArrangedSubview(descriptionStackView)
        setupDescriptionSectionLabel()
        setupDescriptionLabel()
    }
    
    // MARK: Description section label setup
    
    private lazy var descriptionSectionLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.movieScreenStrings.description()
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 24, weight: .bold)
        return myLabel
    }()
    private func setupDescriptionSectionLabel() {
        descriptionStackView.addArrangedSubview(descriptionSectionLabel)
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
    }
    
    // MARK: - Shots StackView setup
    
    private lazy var shotsStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 0
        return myStackView
    }()
    private func setupShotsStackView() {
        stackView.addArrangedSubview(shotsStackView)
        stackView.setCustomSpacing(16, after: shotsStackView)
        setupShotsLabelStack()
        setupShotsCollectionView()
        shotsStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(72 + shotsStackView.spacing + shotsLabel.frame.size.height + 32)
        }
    }
    
    // MARK: Shots label stack setup
    private lazy var shotsLabelStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupShotsLabelStack() {
        shotsStackView.addArrangedSubview(shotsLabelStack)
        shotsLabelStack.addArrangedSubview(shotsLabel)
    }
    
    // MARK: Shots label setup
    
    private lazy var shotsLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.movieScreenStrings.shots()
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 24, weight: .bold)
        myLabel.sizeToFit()
        return myLabel
    }()
    
    // MARK: ShotsCollectionView setup
    
    private lazy var shotsCollectionView: ShotsCollectionView = {
        let myCollectionView = ShotsCollectionView()
        myCollectionView.images = viewModel.movie.imageUrls
        return myCollectionView
    }()
    private func setupShotsCollectionView() {
        shotsStackView.addArrangedSubview(shotsCollectionView)
    }
    
    // MARK: - Episodes StackView setup
    
    private lazy var episodesStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 16
        myStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupEpisodesStackView() {
        stackView.addArrangedSubview(episodesStackView)
        setupEpisodesLabel()
        setupEpisodesTableView()
    }
    
    // MARK: Episodes label setup
    
    private lazy var episodesLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.movieScreenStrings.episodes()
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 24, weight: .bold)
        return myLabel
    }()
    private func setupEpisodesLabel() {
        episodesStackView.addArrangedSubview(episodesLabel)
    }
    
    private lazy var episodesTableView: EpisodesTableView = {
        let myTableView = EpisodesTableView()
        myTableView.viewModel = self.viewModel
        return myTableView
    }()
    private func setupEpisodesTableView() {
        episodesStackView.addArrangedSubview(episodesTableView)
        episodesTableView.snp.remakeConstraints { make in
            make.height.equalTo((72 + 16) * 2)
        }
    }
    private func reloadEpisodesView() {
        if(self.viewModel.episodes.isEmpty) {
            episodesStackView.removeFromSuperview()
        }
        else {
            episodesTableView.reloadData()
        }
    }
    
    
    func getEpisodes() {
        self.episodesTableView.showAnimatedSkeleton(usingColor: R.color.skeletonViewColor() ?? UIColor.skeletonViewColor)
        viewModel.getMovieEpisodesById(movieId: viewModel.movie.movieId) {  success in
            self.episodesTableView.hideSkeleton()
            if(success) {
                self.episodesTableView.snp.remakeConstraints { make in
                    make.height.equalTo(self.episodesTableView.countHeight())
                }
                self.reloadEpisodesView()
                
            }
            else {
                self.showAlert(title: R.string.movieScreenStrings.episodes_loading_error(), message: self.viewModel.error)
            }
        }
    }
    
}
