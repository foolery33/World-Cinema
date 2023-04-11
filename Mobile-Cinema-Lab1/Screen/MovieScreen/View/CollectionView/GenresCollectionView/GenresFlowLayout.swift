//
//  GenresFlowLayout.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 31.03.2023.
//

import Foundation
import UIKit

class GenresFlowLayout: UICollectionViewFlowLayout {
    
    required override init() {super.init(); common()}
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); common()}
    
    private func common() {
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        minimumLineSpacing = 8
        minimumInteritemSpacing = 8
    }
    
    override func layoutAttributesForElements(
                    in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let att = super.layoutAttributesForElements(in:rect) else {return []}
        var x: CGFloat = sectionInset.left
        var y: CGFloat = -1.0
        
        for a in att {
            if a.representedElementCategory != .cell { continue }
            
            if a.frame.origin.y >= y { x = sectionInset.left }
            a.frame.origin.x = x
            x += a.frame.width + minimumInteritemSpacing
            y = a.frame.maxY
        }
        return att
    }
    
//    override var collectionViewContentSize: CGSize {
//        guard let collectionView = collectionView else {
//            return .zero
//        }
//
//        let width = collectionView.bounds.width - sectionInset.left - sectionInset.right
//        var height: CGFloat = 0
//        
//        for section in 0..<collectionView.numberOfSections {
//            for item in 0..<collectionView.numberOfItems(inSection: section) {
//                let indexPath = IndexPath(item: item, section: section)
//                let size = self.collectionView(collectionView, layout: self, sizeForItemAt: indexPath)
//                height = max(height, size.height)
//            }
//        }
//
//        height += sectionInset.top + sectionInset.bottom
//
//        return CGSize(width: width, height: height)
//    }
    
}
