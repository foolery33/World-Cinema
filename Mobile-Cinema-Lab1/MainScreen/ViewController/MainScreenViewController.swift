//
//  MainScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 25.03.2023.
//

import UIKit
import SnapKit

class MainScreenViewController: UIViewController {

    var viewModel: MainScreenViewModel!
    var profiles: [Profile] = []
    var stackViews: [(UIStackView, CGFloat)] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.viewModel.getInTrendMovies { success in
                if(success) {
                    self.reloadInTrendMoviesView()
                }
                else {
                    print("error", self.viewModel.error)
                    let alert = UIAlertController(title: "Movies Loading Failed", message: self.viewModel.error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            self.viewModel.getNewMovies { success in
                if(success) {
                    self.reloadNewMoviesView()
                }
                else {
                    print("error", self.viewModel.error)
                    let alert = UIAlertController(title: "Movies Loading Failed", message: self.viewModel.error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationItem.hidesBackButton = true
        setupSubviews()
    }
    
    private func setupSubviews() {
        setupPoster()
        setupWatchPosterButton()
        setupCollectionsStackView()
//        setupInTrendStackView()
//        setupNewStackView()
    }
    
    // MARK: Poster image setup
    
    private lazy var poster: UIImageView = {
        let myPoster = UIImageView()
        myPoster.image = UIImage(named: "TheMagicians")
        return myPoster
    }()
    private lazy var gradient: CAGradientLayer = {
        let myGradient = CAGradientLayer()
        myGradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        myGradient.startPoint = CGPoint(x: 0, y: 0.7)
        myGradient.endPoint = CGPoint(x: 0, y: 1)
        return myGradient
    }()
    override func viewDidLayoutSubviews() {
        gradient.frame = poster.bounds
        poster.layer.addSublayer(gradient)
    }
    private func setupPoster() {
        view.addSubview(poster)
        poster.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top)
            make.leading.equalTo(view.safeAreaInsets.left)
            make.trailing.equalTo(view.safeAreaInsets.right)
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
        view.addSubview(watchPosterButton)
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
        myStackView.backgroundColor = .blue
        return myStackView
    }()
    private func setupCollectionsStackView() {
        view.addSubview(collectionsStackView)
        setupInTrendStackView()
        setupNewStackView()
        collectionsStackView.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo((144 + inTrendStack.spacing + inTrendLabel.frame.size.height) * 2)
        }
    }
    
    // MARK: - InTrend StackView setup
    private lazy var inTrendStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 16
        myStackView.backgroundColor = .white
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
        stackViews.append((inTrendStack, 144 + inTrendStack.spacing + inTrendLabel.frame.size.height))
        print("InTrendHeight:", 144 + inTrendStack.spacing + inTrendLabel.frame.size.height)
    }
    // MARK: InTrendCollectionView setup
    private lazy var inTrendCollectionView: UICollectionView = {
        let myCollectionView = InTrendCollectionView()
        myCollectionView.viewModel = self.viewModel
        myCollectionView.backgroundColor = .red
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
        if(self.viewModel.inTrendMovies.isEmpty) {
//            removeSection(at: 0)
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
        myStackView.backgroundColor = .purple
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
        stackViews.append((newStack, 144 + newStack.spacing + newLabel.frame.size.height))
        print("NewHeight", 144 + newStack.spacing + newLabel.frame.size.height)
        print("NewFrame", newStack.frame.height)
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
        newMovies.backgroundColor = .red
        newMovies.viewModel = self.viewModel
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
        if(self.viewModel.newMovies.isEmpty) {
            newStack.removeFromSuperview()
        }
        else {
            newCollectionView.reloadData()
            print(viewModel.newMovies.count)
        }
    }
    
    // MARK: - Создать StackView для всех UICollectionView
    
    func removeSection(at index: Int) {
        stackViews[index].0.removeFromSuperview()
        stackViews.remove(at: index)
        var newHeight = 0.0
        // Пересчитываем констрейнты всех следующих stack view, чтобы они сдвинулись вверх
        for i in index..<stackViews.count {
            newHeight += stackViews[i].1
//            stackViews[i].snp.remakeConstraints { make in
//                make.leading.trailing.equalToSuperview()
//                make.height.equalTo(144 + newStack.spacing + newLabel.frame.size.height)
//            }
        }
        collectionsStackView.snp.remakeConstraints { make in
            make.top.equalTo(poster.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(newHeight)
        }
    }
}
