//
//  ProfileSectionTableViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 03.04.2023.
//

import UIKit
import SnapKit

class ProfileSectionTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHStackView()
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage, sectionName: String) {
        self.image.image = image
        self.sectionName.text = sectionName
    }
    
    // MARK: - HStackView setup
    
    private lazy var hStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 18
        myStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupHStackView() {
        contentView.addSubview(hStackView)
        setupImageView()
        setupSectionName()
        setupNextImage()
        hStackView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
    
    // MARK: Image setup
    
    private lazy var image: UIImageView = {
        let myImageView = UIImageView()
        myImageView.contentMode = .scaleAspectFit
        myImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return myImageView
    }()
    private func setupImageView() {
        hStackView.addArrangedSubview(image)
    }
    
    // MARK: SectionName setup
    
    private lazy var sectionName: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 14, weight: .bold)
        myLabel.numberOfLines = 1
        myLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        myLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return myLabel
    }()
    private func setupSectionName() {
        hStackView.addArrangedSubview(sectionName)
    }
    
    // MARK: NextButton setup
    
    private lazy var nextImage: UIImageView = {
        let myImageView = UIImageView()
        myImageView.tintColor = .nextButtonColor
        myImageView.contentMode = .scaleAspectFit
        myImageView.image = R.image.forwardArrow()
        myImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        myImageView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return myImageView
    }()
    private func setupNextImage() {
        hStackView.addArrangedSubview(nextImage)
    }
    
}

extension ProfileSectionTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
