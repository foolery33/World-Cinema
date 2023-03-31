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
//        myScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        myContentView.isHidden = true
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
    
    private lazy var poster: UIImageView = {
        let myPoster = UIImageView()
        myPoster.image = UIImage(named: "TheMagicians")
        myPoster.clipsToBounds = true
        return myPoster
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
            make.bottom.equalTo(poster.snp.bottom).inset(64)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Collections StackView setup
    
    private lazy var collectionsStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 32
//        myStackView.backgroundColor = .blue
        return myStackView
    }()
    private func setupCollectionsStackView() {
        contentView.addSubview(collectionsStackView)
        setupInTrendStackView()
        setupLastSeenStackView()
        setupNewStackView()
        setupForMeStackView()
        setupSetInterestsButton()
        
        collectionsStackView.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-44)
        }
    }
    
    // MARK: - InTrend StackView setup
    private lazy var inTrendStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 16
        return myStackView
    }()
    private func setupInTrendStackView() {
        collectionsStackView.addArrangedSubview(inTrendStack)
        setupInTrendLabel()
        setupInTrendCollectionView()

        inTrendStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(144 + inTrendStack.spacing + inTrendLabel.frame.size.height)
        }
    }
    // MARK: InTrendCollectionView setup
    private lazy var inTrendCollectionView: UICollectionView = {
        let myCollectionView = InTrendCollectionView()
        myCollectionView.viewModel = self.viewModel.inTrendMoviesViewModel
//        myCollectionView.backgroundColor = .red
        return myCollectionView
    }()
    private func setupInTrendCollectionView() {
        inTrendStack.addArrangedSubview(inTrendCollectionView)
        inTrendCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }
    // MARK: InTrend label setup
    private lazy var inTrendLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 0
        myLabel.text = "В тренде"
        myLabel.textColor = .redColor
        myLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        myLabel.sizeToFit()
//        myLabel.backgroundColor = .red
        return myLabel
    }()
    private func setupInTrendLabel() {
        inTrendStack.addArrangedSubview(inTrendLabel)
        inTrendLabel.snp.makeConstraints { make in
            make.leading.equalTo(inTrendStack.snp.leading).inset(16)
        }
    }
    // MARK: Reload InTrendCollectionView
    private func reloadInTrendMoviesView() {
        if(self.viewModel.inTrendMoviesViewModel.inTrendMovies.isEmpty) {
            inTrendStack.removeFromSuperview()
            ()
        }
        else {
            inTrendCollectionView.reloadData()
        }
    }
    
    // MARK: - LastView StackView setup
    private lazy var lastViewStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 16
        return myStackView
    }()
    private func setupLastSeenStackView() {
        collectionsStackView.addArrangedSubview(lastViewStack)
        setupLastViewLabel()
        setupLastViewButton()

        lastViewStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(240 + lastViewStack.spacing + lastViewLabel.frame.size.height)
        }
    }
    // MARK: LastView label setup
    private lazy var lastViewLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 0
        myLabel.text = "Вы смотрели"
        myLabel.textColor = .redColor
        myLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        myLabel.sizeToFit()
//        myLabel.backgroundColor = .red
        return myLabel
    }()
    private func setupLastViewLabel() {
        lastViewStack.addArrangedSubview(lastViewLabel)
        lastViewLabel.snp.makeConstraints { make in
            make.leading.equalTo(lastViewStack.snp.leading).inset(16)
        }
    }
    // MARK: LastViewButton setup
    private lazy var lastViewButton: UIButton = {
        let myButton = UIButton(type: .custom)
        myButton.setImage(UIImage(named: "LastViewFilmPoster"), for: .normal)
        return myButton
    }()
    private func setupLastViewButton() {
        lastViewStack.addArrangedSubview(lastViewButton)
        setupLastViewPlayButton()
        lastViewButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(240)
        }
    }
    // MARK: LastView PlayButton setup
    private lazy var lastViewPlayButton: UIButton = {
        let myButton = UIButton(type: .custom)
        myButton.setImage(UIImage(named: "Polygon"), for: .normal)
        myButton.addImagePressedEffect()
        return myButton
    }()
    private func setupLastViewPlayButton() {
        lastViewButton.addSubview(lastViewPlayButton)
        lastViewPlayButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    // MARK: Reload LastSeenCollectionView
    private func reloadLastViewMoviesView() {
        if(self.viewModel.lastViewMoviesViewModel.lastViewMovies.isEmpty) {
            lastViewStack.removeFromSuperview()
            ()
        }
        else {
            inTrendCollectionView.reloadData()
        }
    }
    
    // MARK: - New StackView setup
    private lazy var newStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 16
//        myStackView.backgroundColor = .purple
        return myStackView
    }()
    private func setupNewStackView() {
        collectionsStackView.addArrangedSubview(newStack)
        setupNewLabel()
        setupNewCollectionView()

        newStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(144 + newStack.spacing + newLabel.frame.size.height)
        }
    }
    // MARK: New label setup
    private lazy var newLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 0
        myLabel.text = "Новое"
        myLabel.textColor = .redColor
        myLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        myLabel.sizeToFit()
        return myLabel
    }()
    private func setupNewLabel() {
        newStack.addArrangedSubview(newLabel)
        newLabel.snp.makeConstraints { make in
            make.leading.equalTo(newStack.snp.leading).inset(16)
        }
    }
    // MARK: - NewCollectionView setup
    private lazy var newCollectionView: UICollectionView = {
        let newMovies = NewCollectionView()
//        newMovies.backgroundColor = .red
        newMovies.viewModel = self.viewModel.newMoviesViewModel
        return newMovies
    }()
    private func setupNewCollectionView() {
        newStack.addArrangedSubview(newCollectionView)
        newCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(144)
        }
    }
    private func reloadNewMoviesView() {
        if(self.viewModel.newMoviesViewModel.newMovies.isEmpty) {
            newStack.removeFromSuperview()
            ()
        }
        else {
            newCollectionView.reloadData()
        }
    }
    
    // MARK: - ForYou StackView setup
    private lazy var forMeStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 16
        return myStackView
    }()
    private func setupForMeStackView() {
        collectionsStackView.addArrangedSubview(forMeStack)
        setupForMeLabel()
        setupMeYouCollectionView()

        forMeStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(144 + forMeStack.spacing + forMeLabel.frame.size.height)
        }
    }
    // MARK: ForYou label setup
    private lazy var forMeLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 0
        myLabel.text = "Для вас"
        myLabel.textColor = .redColor
        myLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        myLabel.sizeToFit()
        return myLabel
    }()
    private func setupForMeLabel() {
        forMeStack.addArrangedSubview(forMeLabel)
        forMeLabel.snp.makeConstraints { make in
            make.leading.equalTo(forMeStack.snp.leading).inset(16)
        }
    }
    // MARK: ForMeCollectionView setup
    private lazy var forMeCollectionView: UICollectionView = {
        let myCollectionView = ForMeCollectionView()
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
    private func reloadForYouMoviesView() {
        if(self.viewModel.inTrendMoviesViewModel.inTrendMovies.isEmpty) {
            forMeStack.removeFromSuperview()
            ()
        }
        else {
            forMeCollectionView.reloadData()
        }
    }
    
    // MARK: - SetInterests button setup
    private lazy var setInterestsButton: UIButton = {
        let myButton = FilledButton()
        return myButton.getFilledButton(label: "Указать интересы", selector: nil)
    }()
    private func setupSetInterestsButton() {
        collectionsStackView.addArrangedSubview(setInterestsButton)
        setInterestsButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    func loadSections() {
        let activityIndicator = ActivityIndicator()
        addSubview(activityIndicator)
        activityIndicator.setupEdges()
        activityIndicator.startAnimating()
        DispatchQueue.main.async {
            self.viewModel.inTrendMoviesViewModel.getInTrendMovies { success in
                if(success) {
                    self.reloadInTrendMoviesView()
                }
                else {
                    print("error", self.viewModel.inTrendMoviesViewModel.error)
                    self.showAlert(title: "Movies Loading Failed", message: self.viewModel.inTrendMoviesViewModel.error)
                }
            }
            self.viewModel.lastViewMoviesViewModel.getLastViewMovies { success in
                if(success) {
                    self.reloadLastViewMoviesView()
                }
                else {
                    self.showAlert(title: "Movies Loading Failed", message: self.viewModel.inTrendMoviesViewModel.error)
                }
            }
            self.viewModel.newMoviesViewModel.getNewMovies { success in
                if(success) {
                    self.reloadNewMoviesView()
                }
                else {
                    self.showAlert(title: "Movies Loading Failed", message: self.viewModel.inTrendMoviesViewModel.error)
                }
            }
            self.viewModel.forMeMoviesViewModel.getForMeMovies { success in
                if(success) {
                    self.reloadForYouMoviesView()
                }
                else {
                    self.showAlert(title: "Movies Loading Failed", message: self.viewModel.inTrendMoviesViewModel.error)
                }
                activityIndicator.stopAnimating()
                self.contentView.isHidden = false
            }
        }
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
