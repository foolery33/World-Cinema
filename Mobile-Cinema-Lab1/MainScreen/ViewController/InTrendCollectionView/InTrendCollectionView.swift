//
//  NewCollectionView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 28.03.2023.
//

import UIKit

class InTrendCollectionView: UICollectionView {
    
    var viewModel: MainScreenViewModel!
    var movies = [
        MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: []),
        MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: []),
        MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: []),
        MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: []),
        MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: []),
        MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: []),
        MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: []),
        MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: []),
        MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: []),
        MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: []),
    ]
    
    // MARK: - InTrendCollectionView setup
    
    convenience init() {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        self.init(frame: .zero, collectionViewLayout: viewLayout)
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        dataSource = self
        delegate = self
        print("registered")
        register(InTrendMovieCell.self, forCellWithReuseIdentifier: InTrendMovieCell.identifier)
    }
    
}

extension InTrendCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count in trend", viewModel.inTrendMovies.count)
//        return viewModel.inTrendMovies.count
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InTrendMovieCell.identifier, for: indexPath) as! InTrendMovieCell

//        let movie = viewModel.inTrendMovies[indexPath.row]
        let movie = movies[indexPath.row]
        cell.setup(with: movie)
        cell.contentView.backgroundColor = .red
        return cell
    }
}

extension InTrendCollectionView: UICollectionViewDelegateFlowLayout {
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