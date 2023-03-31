//
//  GenresCollectionView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 31.03.2023.
//

import UIKit

class GenresCollectionView: UICollectionView {

//    var genres: [String] = ["Comedy", "Tragedy", "Tragedy", "Tragedy", "Tragedy", "Trasdfsdfgedy"]
    
    var genres: [String]?
    
    convenience init() {
        let viewLayout = GenresFlowLayout()
        viewLayout.scrollDirection = .vertical
        self.init(frame: .zero, collectionViewLayout: viewLayout)
        showsHorizontalScrollIndicator = false
        dataSource = self
        delegate = self
        backgroundColor = .clear
        register(GenresCollectionViewCell.self, forCellWithReuseIdentifier: GenresCollectionViewCell.identifier)
    }
    
}


extension GenresCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresCollectionViewCell.identifier, for: indexPath) as! GenresCollectionViewCell

        let genre = genres?[indexPath.row] ?? ""
        cell.setup(with: genre)
        return cell
    }
}

extension GenresCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return genres?[indexPath.row].calculateLabelWidth(font: UIFont.systemFont(ofSize: 14, weight: .regular), widthInset: 32, heightInset: 10) ?? CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension GenresCollectionView {
    func calculateContentHeight() -> CGFloat {
        if let genres {
            var height: CGFloat = genres[0].calculateLabelWidth(font: UIFont.systemFont(ofSize: 14, weight: .regular), widthInset: 32, heightInset: 10).height
            let screenWidth = UIScreen.main.bounds.width - 32
            var numberOfSections = 1
            var currentWidthSum: CGFloat = 0.0
            var currentGenreIndex = 0
            while currentGenreIndex < genres.count{
                let string = genres[currentGenreIndex]
                let stringWidth = string.calculateLabelWidth(font: UIFont.systemFont(ofSize: 14, weight: .regular), widthInset: 32, heightInset: 10).width
                if(currentWidthSum + stringWidth > screenWidth) {
                    height += genres[0].calculateLabelWidth(font: UIFont.systemFont(ofSize: 14, weight: .regular), widthInset: 32, heightInset: 10).height + 8
                    currentWidthSum = stringWidth + 8
                    numberOfSections += 1
                }
                else {
                    currentWidthSum += stringWidth + 8
                }
                currentGenreIndex += 1
            }
            return height
        }
        else {
            return 0
        }
    }
}

extension String {
    func calculateLabelWidth(font: UIFont, widthInset: CGFloat, heightInset: CGFloat) -> CGSize {
        let label = UILabel()
        label.font = font
        label.text = self
        label.sizeToFit()
        return CGSize(width: label.frame.width + widthInset, height: label.frame.height + heightInset)
    }
}
