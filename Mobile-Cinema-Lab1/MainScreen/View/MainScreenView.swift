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
        setupPoster()
        setupWatchPosterButton()
        setupInTrendLabel()
//        setupInTrendCollectionView()
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
        myGradient.startPoint = CGPoint(x: 0, y: 0.7 )
        myGradient.endPoint = CGPoint(x: 0, y: 1)
        return myGradient
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = poster.bounds
        poster.layer.addSublayer(gradient)
    }
    private func setupPoster() {
        addSubview(poster)
        poster.snp.makeConstraints { make in
            make.top.equalTo(safeAreaInsets.top)
            make.leading.trailing.equalToSuperview()
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
        addSubview(watchPosterButton)
        watchPosterButton.snp.makeConstraints { make in
            make.bottom.equalTo(poster.snp.bottom).inset(64)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: InTrend section setup
    
    private lazy var inTrendLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "В тренде"
        myLabel.textColor = .redColor
        myLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return myLabel
    }()
    private func setupInTrendLabel() {
        addSubview(inTrendLabel)
        inTrendLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(poster.snp.bottom).offset(32)
        }
    }
    
    // MARK: InTrend CollectionView setup
    
    private lazy var inTrendCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 16.0
        static let itemHeight: CGFloat = 144
    }
    
    private func setupCollecitonView() {
        addSubview(inTrendCollectionView)
//        inTrendCollectionView.dataSource = self
        inTrendCollectionView.delegate = self
//        inTrendCollectionView.register(InTrendCollectionViewCell.self, forCellWithReuseIdentifier: "NewCell")
        setupLayouts()
    }
    
    private func setupLayouts() {
        inTrendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(inTrendLabel.snp.bottom).inset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}

extension MainScreenView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = itemWidth(for: self.frame.width, spacing: LayoutConstant.spacing)
        
        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2
        
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
}
