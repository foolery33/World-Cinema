//
//  MainScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 25.03.2023.
//

import UIKit
import SnapKit

class MainScreenView: UIView {
    
    var viewModel: MainScreenViewModel
    
    init(viewModel: MainScreenViewModel) {
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
        myContentView.isSkeletonable = true
        return myContentView
    }()
    private func setupContentView() {
        scrollView.addSubview(contentView)
        setupPoster()
        setupWatchPosterButton()
        setupCollectionsStackView()
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - Poster image setup
    
    lazy var poster: UIImageView = {
        let myPoster = UIImageView()
        myPoster.clipsToBounds = true
        myPoster.isSkeletonable = true
        return myPoster
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
    
    // MARK: Watch poster button setup
    
    private lazy var watchPosterButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setTitle(R.string.mainScreenStrings.watch(), for: .normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        myButton.setTitleColor(.white, for: .normal)
        myButton.contentEdgeInsets = Scales.watchPosterButtonInsets
        myButton.backgroundColor = .redColor
        myButton.layer.cornerRadius = 4
        return myButton
    }()
    private func setupWatchPosterButton() {
        contentView.addSubview(watchPosterButton)
        watchPosterButton.snp.makeConstraints { make in
            make.bottom.equalTo(poster.snp.bottom).inset(Paddings.watchPosterBottomPadding)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Collections StackView setup
    
    private lazy var collectionsStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.axis = .vertical
        myStackView.spacing = CGFloat(Constants.collectionsStackViewSpacing)
        return myStackView
    }()
    private func setupCollectionsStackView() {
        contentView.addSubview(collectionsStackView)
        setupInTrendStackView()
        setupLastViewStackView()
        setupNewStackView()
        setupForMeStackView()
        setupInterestsButtonStack()
        
        collectionsStackView.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom).offset(Paddings.doubleDefaultPadding)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(Paddings.collectionsStackViewBottomPadding)
        }
    }
    
    // MARK: - InTrend StackView setup
    private lazy var inTrendStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.axis = .vertical
        myStackView.spacing = CGFloat(Constants.inTrendStackViewSpacing)
        return myStackView
    }()
    private func setupInTrendStackView() {
        collectionsStackView.addArrangedSubview(inTrendStack)
        setupInTrendStack()
        setupInTrendCollectionView()

        inTrendStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Scales.inTrendCollectionViewCellHeight + inTrendStack.spacing + inTrendLabel.frame.size.height)
        }
    }
    // MARK: InTrendCollectionView setup
    private lazy var inTrendCollectionView: UICollectionView = {
        let myCollectionView = InTrendCollectionView()
        myCollectionView.isSkeletonable = true
        myCollectionView.viewModel = self.viewModel.inTrendMoviesViewModel
        return myCollectionView
    }()
    private func setupInTrendCollectionView() {
        inTrendStack.addArrangedSubview(inTrendCollectionView)
        inTrendCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }
    // MARK: InTrend label stack setup
    private lazy var inTrendLabelStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.layoutMargins = Scales.inTrendLabelStackMargins
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupInTrendStack() {
        inTrendStack.addArrangedSubview(inTrendLabelStack)
        inTrendLabelStack.addArrangedSubview(inTrendLabel)
    }
    // MARK: InTrend label setup
    private lazy var inTrendLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
        myLabel.numberOfLines = Constants.unlimitedLines
        myLabel.text = R.string.mainScreenStrings.in_trend()
        myLabel.textColor = .redColor
        myLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        myLabel.sizeToFit()
        return myLabel
    }()
    // MARK: Reload InTrendCollectionView
    func reloadInTrendMoviesView() {
        if(self.viewModel.inTrendMoviesViewModel.inTrendMovies.isEmpty) {
            inTrendStack.removeFromSuperview()
        }
        else {
            inTrendCollectionView.reloadData()
            self.inTrendStack.hideSkeleton()
        }
    }
    
    // MARK: - LastView StackView setup
    private lazy var lastViewStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.axis = .vertical
        myStackView.spacing = CGFloat(Constants.lastStackViewSpacing)
        return myStackView
    }()
    private func setupLastViewStackView() {
        collectionsStackView.addArrangedSubview(lastViewStack)
        setupLastViewStack()
        setupLastViewImageView()

        lastViewStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Scales.lastViewImageHeight + lastViewStack.spacing + lastViewLabel.frame.size.height)
        }
    }
    // MARK: InTrend label stack setup
    private lazy var lastViewLabelStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.layoutMargins = Scales.lastViewLabelStackMargins
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupLastViewStack() {
        lastViewStack.addArrangedSubview(lastViewLabelStack)
        lastViewLabelStack.addArrangedSubview(lastViewLabel)
    }
    // MARK: LastView label setup
    private lazy var lastViewLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
        myLabel.numberOfLines = Constants.unlimitedLines
        myLabel.text = R.string.mainScreenStrings.you_watched()
        myLabel.textColor = .redColor
        myLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        myLabel.sizeToFit()
        return myLabel
    }()
    // MARK: LastViewImageView setup
    private lazy var lastViewImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.isSkeletonable = true
        myImageView.contentMode = .scaleAspectFit
        myImageView.clipsToBounds = true
        myImageView.isUserInteractionEnabled = true
        myImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLastViewMovieButtonClicked)))
        return myImageView
    }()
    private func setupLastViewImageView() {
        lastViewStack.addArrangedSubview(lastViewImageView)
        setupLastViewPlayButton()
        setupLastNameView()
        lastViewImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Scales.lastViewImageHeight)
        }
    }
    // MARK: LastView PlayButton setup
    private lazy var lastViewPlayButton: UIButton = {
        let myButton = UIButton(type: .custom)
        myButton.setImage(R.image.polygon(), for: .normal)
        myButton.addImagePressedEffect()
        myButton.addTarget(self, action: #selector(onLastViewMovieButtonClicked), for: .touchUpInside)
        return myButton
    }()
    private func setupLastViewPlayButton() {
        lastViewImageView.addSubview(lastViewPlayButton)
        lastViewPlayButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    // MARK: LastViewLabel setup
    private lazy var lastViewNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 14, weight: .bold)
        myLabel.numberOfLines = 1
        return myLabel
    }()
    private func setupLastNameView() {
        lastViewImageView.addSubview(lastViewNameLabel)
        lastViewNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    // MARK: Reload LastSeenCollectionView
    func reloadLastViewMoviesView() {
        if(self.viewModel.lastViewMoviesViewModel.lastViewMovies.isEmpty) {
            lastViewStack.removeFromSuperview()
        }
        else {
            self.lastViewImageView.loadImageWithURL(self.viewModel.lastViewMoviesViewModel.history[0].preview, contentMode: .scaleAspectFill)
            self.lastViewNameLabel.text = self.viewModel.lastViewMoviesViewModel.history[0].episodeName
            self.lastViewStack.hideSkeleton()
        }
    }
    @objc private func onLastViewMovieButtonClicked() {
        self.setupActivityIndicator()
        self.viewModel.lastViewMoviesViewModel.getEpisode { success in
            self.stopActivityIndicator()
            if success {
                self.viewModel.lastViewMoviesViewModel.goToEpisodeScreen()
            }
            else {
                self.showAlert(title: R.string.mainScreenStrings.episode_loading_error(), message: self.viewModel.lastViewMoviesViewModel.error)
            }
        }
    }
    
    // MARK: - New StackView setup
    private lazy var newStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.axis = .vertical
        myStackView.spacing = CGFloat(Constants.newStackSpacing)
        return myStackView
    }()
    private func setupNewStackView() {
        collectionsStackView.addArrangedSubview(newStack)
        setupNewLabelStack()
        setupNewCollectionView()

        newStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Scales.newStackViewCellHeight + newStack.spacing + newLabel.frame.size.height)
        }
    }
    // MARK: New label stack setup
    private lazy var newLabelStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.layoutMargins = Scales.newLabelStackMargins
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupNewLabelStack() {
        newStack.addArrangedSubview(newLabelStack)
        newLabelStack.addArrangedSubview(newLabel)
    }
    // MARK: New label setup
    private lazy var newLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
        myLabel.numberOfLines = Constants.unlimitedLines
        myLabel.text = R.string.mainScreenStrings.new()
        myLabel.textColor = .redColor
        myLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        myLabel.sizeToFit()
        return myLabel
    }()
    // MARK: - NewCollectionView setup
    private lazy var newCollectionView: UICollectionView = {
        let newMovies = NewCollectionView()
        newMovies.isSkeletonable = true
        newMovies.viewModel = self.viewModel.newMoviesViewModel
        return newMovies
    }()
    private func setupNewCollectionView() {
        newStack.addArrangedSubview(newCollectionView)
        newCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }
    func reloadNewMoviesView() {
        if(self.viewModel.newMoviesViewModel.newMovies.isEmpty) {
            newStack.removeFromSuperview()
        }
        else {
            newCollectionView.reloadData()
            self.newStack.hideSkeleton()
        }
    }
    
    // MARK: - ForYou StackView setup
    private lazy var forMeStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.axis = .vertical
        myStackView.spacing = CGFloat(Constants.forMeStackSpacing)
        return myStackView
    }()
    private func setupForMeStackView() {
        collectionsStackView.addArrangedSubview(forMeStack)
        setupForMeStack()
        setupMeYouCollectionView()

        forMeStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Scales.newStackViewCellHeight + forMeStack.spacing + forMeLabel.frame.size.height)
        }
    }
    // MARK: ForMe label stack setup
    private lazy var forMeLabelStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.layoutMargins = Scales.forMeLabelStackMargins
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupForMeStack() {
        forMeStack.addArrangedSubview(forMeLabelStack)
        forMeLabelStack.addArrangedSubview(forMeLabel)
    }
    // MARK: ForYou label setup
    private lazy var forMeLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
        myLabel.numberOfLines = Constants.unlimitedLines
        myLabel.text = R.string.mainScreenStrings.for_you()
        myLabel.textColor = .redColor
        myLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        myLabel.sizeToFit()
        return myLabel
    }()
    // MARK: ForMeCollectionView setup
    private lazy var forMeCollectionView: UICollectionView = {
        let myCollectionView = ForMeCollectionView()
        myCollectionView.isSkeletonable = true
        myCollectionView.viewModel = self.viewModel.forMeMoviesViewModel
        return myCollectionView
    }()
    private func setupMeYouCollectionView() {
        forMeStack.addArrangedSubview(forMeCollectionView)
        forMeCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }
    // MARK: Reload InTrendCollectionView
    func reloadForYouMoviesView() {
        if(self.viewModel.inTrendMoviesViewModel.inTrendMovies.isEmpty) {
            forMeStack.removeFromSuperview()
        }
        else {
            forMeCollectionView.reloadData()
            self.forMeStack.hideSkeleton()
        }
    }
    
    // MARK: - SetInterests button stack setup
    private lazy var setInretestsButtonStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.layoutMargins = Scales.setInterestsButtonStackMargins
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupInterestsButtonStack() {
        collectionsStackView.addArrangedSubview(setInretestsButtonStack)
        setInretestsButtonStack.addArrangedSubview(setInterestsButton)
    }
    // MARK: SetInterests button setup
    private lazy var setInterestsButton: UIButton = {
        let myButton = FilledButton()
        return myButton.getFilledButton(label: R.string.mainScreenStrings.set_interests(), selector: nil)
    }()
    
}

extension MainScreenView {
    func setupSkeleton() {
        self.contentView.showAnimatedSkeleton(usingColor: R.color.skeletonViewColor() ?? UIColor.skeletonViewColor)
    }
    
    func stopSkeleton() {
    }
    
}

extension UIButton {
    func addImagePressedEffect() {
        // Добавляем обработчик нажатия на кнопку
        addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchDown)
    }

    @objc private func buttonPressed(sender: UIButton) {
        self.imageView?.alpha = 0.5
        // Устанавливаем временную прозрачность для изображения кнопки при нажатии
        UIView.animate(withDuration: 0.2, animations: {
            self.imageView?.alpha = 1.0
        })
    }
}
