//
//  MainScreenViewConstants.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 22.04.2023.
//

import Foundation
import UIKit

extension MainScreenView {
    enum Paddings {
        static let watchPosterBottomPadding = 64.0
        static let defaultPadding = 16.0
        static let doubleDefaultPadding = 2 * defaultPadding
        static let collectionsStackViewBottomPadding = -44.0
    }
    enum Scales {
        static let posterHeight = 400.0
        static let watchPosterButtonInsets = UIEdgeInsets(top: 13, left: 32, bottom: 13, right: 32)

        static let inTrendCollectionViewCellHeight = 144.0
        static let inTrendLabelStackMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        static let lastViewImageHeight = 240.0
        static let lastViewLabelStackMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        static let newStackViewCellHeight = 144.0
        static let newLabelStackMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        static let forMeLabelStackMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        static let setInterestsButtonStackMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    enum Constants {
        static let unlimitedLines = 0
        static let collectionsStackViewSpacing = 32
        static let inTrendStackViewSpacing = 16
        static let lastStackViewSpacing = 16
        static let newStackSpacing = 16
        static let forMeStackSpacing = 16
        static let gradientStartPoint = CGPoint(x: 0, y: 0.7)
        static let gradientEndPoint = CGPoint(x: 0, y: 1)
    }
}
