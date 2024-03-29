//
//  GenresCollectionViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 31.03.2023.
//

import UIKit
import SnapKit

final class GenresCollectionViewCell: UICollectionViewCell {
    
    private let genreLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        myLabel.textColor = .white
        return myLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupGenreLabel()
    }

    private func setupViews() {
        contentView.clipsToBounds = true
    }

    private func setupGenreLabel() {
        contentView.addSubview(genreLabel)
        contentView.backgroundColor = .redColor
        contentView.layer.cornerRadius = 4
        genreLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16))
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with genre: String) {
        genreLabel.text = genre
    }
}


extension GenresCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
