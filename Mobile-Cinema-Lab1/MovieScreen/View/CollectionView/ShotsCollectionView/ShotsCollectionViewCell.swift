//
//  ShotsCollectionViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 01.04.2023.
//

import UIKit
import SnapKit

class ShotsCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupImageView()
    }

    private func setupViews() {
        contentView.clipsToBounds = true
    }

    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with image: String) {
        print(image)
        imageView.loadImageWithURL(image)
    }
}


extension ShotsCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
