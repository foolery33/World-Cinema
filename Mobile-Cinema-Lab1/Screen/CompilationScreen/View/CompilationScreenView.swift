//
//  CompilationScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 10.04.2023.
//

import UIKit
import SnapKit

class CompilationScreenView: UIView {

    var viewModel: CompilationScreenViewModel
    lazy var initialFrontCardCenter: CGPoint = frontCompilationCardView.center
    var divisor: CGFloat = UIScreen.main.bounds.width
    var currentMovieIndex: Int = 0
    
    init(viewModel: CompilationScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupScrollView()
    }
    
    // MARK: - ScrollView setup
    
    lazy var scrollView: UIScrollView = {
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
    
    lazy var contentView: UIView = {
        let myView = UIView()
        return myView
    }()
    private func setupContentView() {
        scrollView.addSubview(contentView)
        setupFilmLabel()
        setupBackCompilationCardView()
        setupFrontCompilationCardView()
        setupButtonsStack()
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - FilmLabel setup
    
    lazy var filmLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Altered Carbon"
        myLabel.font = .systemFont(ofSize: 24, weight: .bold)
        myLabel.textColor = .white
        myLabel.numberOfLines = 1
        myLabel.textAlignment = .center
        return myLabel
    }()
    private func setupFilmLabel() {
        contentView.addSubview(filmLabel)
        filmLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - BackCompilationCardView
    
    lazy var backCompilationCardView: CompilationCardView = {
        let myCompilationCardView = CompilationCardView()
        return myCompilationCardView
    }()
    private func setupBackCompilationCardView() {
        contentView.addSubview(backCompilationCardView)
        backCompilationCardView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(filmLabel.snp.bottom).offset(24)
        }
    }
    
    // MARK: - FrontCompilationCardView setup
    
    lazy var frontCompilationCardView: CompilationCardView = {
        let myCompilationCardView = CompilationCardView()
        myCompilationCardView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panCard(_:))))
        return myCompilationCardView
    }()
    private func setupFrontCompilationCardView() {
        contentView.addSubview(frontCompilationCardView)
        frontCompilationCardView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(filmLabel.snp.bottom).offset(24)
        }
    }

    // MARK: - ButtonsStack setup
    
    private lazy var buttonsStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 44
        return myStackView
    }()
    private func setupButtonsStack() {
        contentView.addSubview(buttonsStack)
        setupRejectButton()
        setupPlayButton()
        setupLikeButton()
        buttonsStack.snp.makeConstraints { make in
            make.top.equalTo(frontCompilationCardView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-32)
        }
    }
    
    // MARK: RejectButton setup
    
    private lazy var rejectButton: UIButton = {
        let myButton = UIButton(type: .custom)
        myButton.layer.cornerRadius = 0.5 * 56
        myButton.clipsToBounds = true
        myButton.backgroundColor = .white
        myButton.setImage(UIImage(named: "Reject"), for: .normal)
        myButton.addImagePressedEffect()
        myButton.addTarget(self, action: #selector(self.dislikeAnimation), for: .touchUpInside)
        return myButton
    }()
    private func setupRejectButton() {
        buttonsStack.addArrangedSubview(rejectButton)
        rejectButton.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
    }
    
    // MARK: PlayButton setup
    
    private lazy var playButton: UIButton = {
        let myButton = UIButton(type: .custom)
        myButton.layer.cornerRadius = 0.5 * 56
        myButton.clipsToBounds = true
        myButton.backgroundColor = .redColor
        myButton.setImage(UIImage(named: "Play"), for: .normal)
        myButton.addImagePressedEffect()
        myButton.addTarget(self, action: #selector(goToMovieScreen), for: .touchUpInside)
        return myButton
    }()
    private func setupPlayButton() {
        buttonsStack.addArrangedSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
    }
    @objc private func goToMovieScreen() {
        self.viewModel.goToMovieScreen(movie: self.viewModel.movies[self.currentMovieIndex - 1])
    }
    
    // MARK: LikeButton setup
    
    private lazy var likeButton: UIButton = {
        let myButton = UIButton(type: .custom)
        myButton.layer.cornerRadius = 0.5 * 56
        myButton.clipsToBounds = true
        myButton.backgroundColor = .white
        myButton.setImage(UIImage(named: "Like"), for: .normal)
        myButton.addImagePressedEffect()
        myButton.addTarget(self, action: #selector(self.likeAnimation), for: .touchUpInside)
        return myButton
    }()
    private func setupLikeButton() {
        buttonsStack.addArrangedSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
    }
    
}
