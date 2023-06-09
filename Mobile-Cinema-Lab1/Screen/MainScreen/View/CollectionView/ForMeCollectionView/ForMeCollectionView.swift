//
//  NewCollectionView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 31.03.2023.
//

import UIKit
import SkeletonView

class ForMeCollectionView: UICollectionView {
    
    var viewModel: ForMeMoviesViewModel!
    
    // MARK: - InTrendCollectionView setup
    
    convenience init() {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        self.init(frame: .zero, collectionViewLayout: viewLayout)
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        dataSource = self
        delegate = self
        register(ForMeCollectionViewCell.self, forCellWithReuseIdentifier: ForMeCollectionViewCell.identifier)
    }
    
}

extension ForMeCollectionView: SkeletonCollectionViewDataSource {
    
    // MARK: - SkeletonCollectionViewDataSource
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return ForMeCollectionViewCell.identifier
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.forMeMovies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForMeCollectionViewCell.identifier, for: indexPath) as! ForMeCollectionViewCell

        let movie = viewModel.forMeMovies[indexPath.row]
        cell.setup(with: movie)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.coordinator?.goToMovieScreen(movie: viewModel?.forMeMovies[indexPath.row] ?? MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: "", lastMessage: MessageModel(messageId: "", creationDateTime: "", authorName: "", text: "")), imageUrls: [], poster: "", tags: []))
    }
}

extension ForMeCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 144)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
