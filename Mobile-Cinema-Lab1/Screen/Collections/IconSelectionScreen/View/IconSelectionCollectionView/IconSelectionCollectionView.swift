//
//  IconSelectionCollectionView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 06.04.2023.
//

import UIKit

class IconSelectionCollectionView: UICollectionView {

    let icons = Array(1...36)
    
    // MARK: - InTrendCollectionView setup
    
    convenience init() {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        self.init(frame: .zero, collectionViewLayout: viewLayout)
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        dataSource = self
        delegate = self
        register(IconSelectionCollectionViewCell.self, forCellWithReuseIdentifier: IconSelectionCollectionViewCell.identifier)
    }
    
}

extension IconSelectionCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconSelectionCollectionViewCell.identifier, for: indexPath) as! IconSelectionCollectionViewCell

        let icon = icons[indexPath.row]
        let iconName = "Group \(icon)"
        cell.setup(with: iconName)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = self.next?.next as? IconSelectionScreenViewController {
            viewController.delegate.choose(iconName: "Group \(icons[indexPath.row])")
            viewController.dismiss(animated: true)
        }
    }
}

extension IconSelectionCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 74, height: 74)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
