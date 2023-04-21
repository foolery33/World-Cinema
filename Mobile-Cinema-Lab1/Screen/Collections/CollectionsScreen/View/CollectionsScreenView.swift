//
//  CollectionsScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import UIKit
import SnapKit
import SkeletonView

class CollectionsScreenView: UIView {

    var viewModel: CollectionsScreenViewModel
    
    init(viewModel: CollectionsScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupCollectionsTableView()
    }
    
    private lazy var collectionsTableView: CollectionsTableView = {
        let myTableView = CollectionsTableView()
        myTableView.isSkeletonable = true
        myTableView.viewModel = self.viewModel
        myTableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        return myTableView
    }()
    private func setupCollectionsTableView() {
        addSubview(collectionsTableView)
        collectionsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func loadCollections() {
//        self.setupActivityIndicator()
        self.collectionsTableView.showAnimatedSkeleton(usingColor: UIColor(red: 33/255, green: 21/255, blue: 18/255, alpha: 1))
        viewModel.getCollections { success in
//            self.stopActivityIndicator()
            self.collectionsTableView.hideSkeleton()
            if(success) {
                self.reloadCollectionsTableView()
            }
            else {
                self.showAlert(title: "Collections Loading Error", message: self.viewModel.error)
            }
        }
    }
    
    func reloadCollectionsTableView() {
        self.collectionsTableView.reloadData()
    }
    
}
