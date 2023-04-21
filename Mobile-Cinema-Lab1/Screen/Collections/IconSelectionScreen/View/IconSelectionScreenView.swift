//
//  IconSelectionScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 06.04.2023.
//

import UIKit
import SnapKit

class IconSelectionScreenView: UIView {

    
    init() {
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupIconSelectionCollectionView()
    }
    
    // MARK: IconSelectionCollectionView setup
    
    private lazy var iconSelectionCollectionView: IconSelectionCollectionView = {
        let myCollecitonView = IconSelectionCollectionView()
        return myCollecitonView
    }()
    private func setupIconSelectionCollectionView() {
        addSubview(iconSelectionCollectionView)
        
        iconSelectionCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
