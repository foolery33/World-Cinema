//
//  MovieScreenViewConstants.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 22.04.2023.
//

import Foundation
import UIKit

extension MovieScreenView {
    enum Paddings {
        static let watchPosterBottomPadding = 64.0
        static let defaultPadding = 16.0
        static let doubleDefaultPadding = 2 * defaultPadding
        static let collectionsStackViewBottomPadding = -44.0
    }
    enum Scales {
        static let posterHeight = 400.0
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
