//
//  CreateCollectionScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 08.04.2023.
//

import UIKit
import SnapKit
import SkeletonView

class CollectionScreenView: UIView {

    var viewModel: CollectionScreenViewModel
    
    init(viewModel: CollectionScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupCollectionMoviesTableView()
    }
    
    // MARK: CollectionMoviesTableView setup
    
    private lazy var collectionMoviesTableView: CollectionMoviesTableView = {
        let myTableView = CollectionMoviesTableView()
        myTableView.isSkeletonable = true
        myTableView.viewModel = self.viewModel
        myTableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        return myTableView
    }()
    private func setupCollectionMoviesTableView() {
        addSubview(collectionMoviesTableView)
        collectionMoviesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func getMoviesFromCollection() {
        self.collectionMoviesTableView.showAnimatedSkeleton(usingColor: R.color.skeletonViewColor() ?? UIColor.skeletonViewColor)
        self.viewModel.getMoviesFromCollection(collectionId: self.viewModel.collection.collectionId) { success in
            if(success) {
                self.collectionMoviesTableView.hideSkeleton()
                self.collectionMoviesTableView.reloadData()
                self.collectionMoviesTableView.snp.remakeConstraints { make in
                    make.edges.equalToSuperview()
                }
                print(self.collectionMoviesTableView.countHeight())
            }
            else {
                self.showAlert(title: R.string.collectionScreenStrings.movies_loading_error(), message: self.viewModel.error)
            }
        }
    }
    
}
