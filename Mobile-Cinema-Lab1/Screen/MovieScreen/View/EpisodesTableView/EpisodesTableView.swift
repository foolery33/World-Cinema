//
//  EpisodesTableView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 01.04.2023.
//

import UIKit
import SkeletonView

class EpisodesTableView: UITableView {

    var viewModel: MovieScreenViewModel?
    
    init() {
        super.init(frame: .zero, style: .plain)
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        dataSource = self
        delegate = self
        separatorStyle = .none
        self.register(EpisodesTableViewCell.self, forCellReuseIdentifier: EpisodesTableViewCell.identifier)
        self.isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension EpisodesTableView: SkeletonTableViewDataSource {
    
    // MARK: - SkeletonCollectionViewDataSource

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return EpisodesTableViewCell.identifier
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("episodesCount", viewModel?.episodes.count ?? 0)
        return viewModel?.episodes.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodesTableViewCell.identifier, for: indexPath) as! EpisodesTableViewCell
        
        let episode = viewModel?.episodes[indexPath.row] ?? EpisodeModel(episodeId: "", name: "", description: "", director: "", stars: [], year: 0, images: [], runtime: 0, preview: "", filePath: "")
        cell.setup(with: episode, isLast: indexPath.row == (viewModel?.episodes.count ?? 0) - 1)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked")
        viewModel?.coordinator.goToEpisodeScreen(
            yearRange: GetYearRangeForEpisodesUseCase().getRange(episodes: viewModel?.episodes ?? []),
            episode: viewModel?.episodes[indexPath.row] ?? EpisodeModel(episodeId: "", name: "", description: "", director: "", stars: [], year: 0, images: [], runtime: 0, preview: "", filePath: ""),
            movie: viewModel?.movie ?? MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: "", lastMessage: MessageModel(messageId: "", creationDateTime: "", authorName: "", text: "")), imageUrls: [], poster: "", tags: []))
    }
}

extension EpisodesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72 + 16
    }
}

extension EpisodesTableView {
    func countHeight() -> CGFloat {
        return (CGFloat(72 + 16) * CGFloat(self.viewModel?.episodes.count ?? 0))
    }
}
