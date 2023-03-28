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
//                    self.reloadNewMoviesView()
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
        setupInTrendStackView()
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
    
    // MARK: - InTrend StackView setup
    private lazy var inTrendStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 16
        myStackView.backgroundColor = .white
        return myStackView
    }()
    private func setupInTrendStackView() {
        view.addSubview(inTrendStack)
        setupInTrendLabel()
        setupInTrendCollectionView()
        print(144 + inTrendStack.spacing + inTrendLabel.frame.size.height)
        inTrendStack.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(144 + inTrendStack.spacing + inTrendLabel.frame.size.height)
        }
    }
    // MARK: InTrendCollectionView setup
    private lazy var inTrendCollectionView: UICollectionView = {
        let colle = InTrendCollectionView()
        colle.viewModel = self.viewModel
        colle.backgroundColor = .red
        return colle
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
            inTrendStack.isHidden = true
        }
        else {
            inTrendCollectionView.reloadData()
        }
    }
    
    // MARK: - New label setup
    
    private lazy var newLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 0
        myLabel.text = "Новое"
        myLabel.textColor = .redColor
        myLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return myLabel
    }()
    
    // MARK: - NewCollectionView setup
    
    private lazy var newCollectionView: UICollectionView = {
        let newMovies = NewCollectionView()
        newMovies.viewModel = self.viewModel
        return newMovies
    }()
    private func reloadNewMoviesView() {
        if(self.viewModel.newMovies.isEmpty) {
            newLabel.isHidden = true
        }
        else {
            newCollectionView.reloadData()
            print(viewModel.newMovies.count)
        }
    }
}
