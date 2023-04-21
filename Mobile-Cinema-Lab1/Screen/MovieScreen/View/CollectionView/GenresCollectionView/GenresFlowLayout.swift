//
//  GenresFlowLayout.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 31.03.2023.
//

import Foundation
import UIKit

class GenresFlowLayout: UICollectionViewFlowLayout {
    
    required override init() {
        super.init()
        common()
    }
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        common()
    }
    
    private func common() {
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        minimumLineSpacing = 8
        minimumInteritemSpacing = 8
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return [] }
        var x: CGFloat = sectionInset.left
        var y: CGFloat = -1.0
        
        for attribute in attributes {
            if attribute.representedElementCategory != .cell { continue }
            
            if attribute.frame.origin.y >= y {
                x = sectionInset.left
            }
            attribute.frame.origin.x = x
            x += attribute.frame.width + minimumInteritemSpacing
            y = attribute.frame.maxY
        }
        return attributes
    }
    
}
