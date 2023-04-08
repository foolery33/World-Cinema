//
//  CollectionsTableView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import UIKit

class CollectionsTableView: UITableView {
    
    var viewModel: CollectionsScreenViewModel?
    
    init() {
        super.init(frame: .zero, style: .plain)
        showsVerticalScrollIndicator = false
        dataSource = self
        delegate = self
        separatorStyle = .none
        backgroundColor = .clear
        self.register(CollectionsTableViewCell.self, forCellReuseIdentifier: CollectionsTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CollectionsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.collections.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionsTableViewCell.identifier, for: indexPath) as! CollectionsTableViewCell
        let section = viewModel?.collections[indexPath.row]
        
        let image: UIImage = UIImage(named: viewModel?.collectionsDatabase.getCollectionById(id: section?.collectionId ?? "")?.imageName ?? "Group 1")!
//        let image: UIImage = UIImage(named: CollectionsManager.shared.fetchCollection(collectionId: section?.collectionId ?? "")) ?? UIImage(named: "Group 1")!
        if(indexPath.row == 0) {
            cell.setup(image: image.resizeImage(newWidth: Scales.firstIconScale, newHeight: Scales.firstIconScale), sectionName: section?.name ?? "")
        }
        else {
            cell.setup(image: image.resizeImage(newWidth: Scales.defaultIconScale, newHeight: Scales.defaultIconScale), sectionName: section?.name ?? "")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked")
    }
}

extension CollectionsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0) {
            return Scales.firstCellHeight
        }
        else {
            if(indexPath.row == (viewModel?.collections.count ?? 0) - 1) {
                return Scales.lastCellHeight
            }
            else {
                return Scales.defaultCellHeight
            }
        }
    }
}


extension CollectionsTableView {
    func countHeight() -> CGFloat {
        return Scales.firstCellHeight + CGFloat((viewModel?.collections.count ?? 0) - 2) * Scales.defaultCellHeight + 56
    }
}

private enum Scales {
    // first cell
    static let firstCellHeight: CGFloat = 82.0
    static let firstIconScale: CGFloat = 56.0
    static let firstAfterIconSpacing: CGFloat = 24.0
    static let firstCellLayoutMargin: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    // any other cell
    static let defaultCellHeight: CGFloat = 76.0
    static let defaultIconScale: CGFloat = 44.0
    static let defaultAfterIconSpacing: CGFloat = 24.0
    static let defaultCellLayoutMargin: UIEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 16)
    
    // last cell
    static let lastCellHeight: CGFloat = firstIconScale
}
