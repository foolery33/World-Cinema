//
//  CollectionMoviesTableView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 08.04.2023.
//

import UIKit

class CollectionMoviesTableView: UITableView {
    
    var viewModel: CollectionScreenViewModel?
    
    init() {
        super.init(frame: .zero, style: .plain)
        showsVerticalScrollIndicator = false
        dataSource = self
        delegate = self
        separatorStyle = .none
        backgroundColor = .clear
        self.register(CollectionMoviesTableViewCell.self, forCellReuseIdentifier: CollectionMoviesTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CollectionMoviesTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movies.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionMoviesTableViewCell.identifier, for: indexPath) as! CollectionMoviesTableViewCell
        let movie = viewModel?.movies[indexPath.row] ?? MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: [])

        cell.setup(movie: movie)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.goToMovieScreen(movie: viewModel?.movies[indexPath.row] ?? MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: []))
    }
}

extension CollectionMoviesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Scales.cellHeight
    }
}


extension CollectionMoviesTableView {
    func countHeight() -> CGFloat {
        return CGFloat(viewModel?.movies.count ?? 0) * Scales.cellHeight
    }
}

private enum Scales {
    static let cellHeight: CGFloat = 96
}
