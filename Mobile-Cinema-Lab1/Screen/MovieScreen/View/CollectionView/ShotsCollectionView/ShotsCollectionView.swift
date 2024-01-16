//
//  ShotsCollectionView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 01.04.2023.
//

import UIKit

class ShotsCollectionView: UICollectionView {

    var images: [String]?
    
    // MARK: - InTrendCollectionView setup
    
    convenience init() {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        self.init(frame: .zero, collectionViewLayout: viewLayout)
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        dataSource = self
        delegate = self
        register(ShotsCollectionViewCell.self, forCellWithReuseIdentifier: ShotsCollectionViewCell.identifier)
    }
    
}

extension ShotsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShotsCollectionViewCell.identifier, for: indexPath) as! ShotsCollectionViewCell

        let image = images?[indexPath.row] ?? ""
        cell.setup(with: image)
        return cell
    }
}

extension ShotsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 72)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

