//
//  CollectionsTableViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import UIKit
import SkeletonView

class CollectionsTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHStackView()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.isSkeletonable = true
        self.contentView.isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage, sectionName: String) {
        self.nextImage.tintColor = .nextButtonColor
        self.image.image = image
        self.sectionName.text = sectionName
    }
    
    // MARK: - HStackView setup
    
    private lazy var hStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.axis = .horizontal
        myStackView.spacing = 18
        myStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupHStackView() {
        contentView.addSubview(hStackView)
        setupImageBox()
        setupSectionName()
        setupNextImage()
        hStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    // MARK: ImageBox setup
    
    private lazy var imageBox: UIView = {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 56, height: 56))
        myView.layer.cornerRadius = self.frame.height / 2
        myView.clipsToBounds = true
        myView.isSkeletonable = true
        return myView
    }()
    private lazy var box: UIView = {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        myView.isSkeletonable = true
        myView.layer.cornerRadius = self.frame.height / 2
        myView.clipsToBounds = true
        return myView
    }()
    private func setupBox() {
        // Устанавливаем box в центре imageBox
        box.frame = imageBox.bounds
        imageBox.addSubview(box)
        
        // Устанавливаем image в центре box
        image.frame = box.bounds
        box.addSubview(image)
    }
    private func setupImageBox() {
        hStackView.addArrangedSubview(imageBox)
        setupBox()
        imageBox.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
    }
    
    // MARK: Image setup
    
    private lazy var image: UIImageView = {
        let myImageView = UIImageView()
        myImageView.isSkeletonable = true
        myImageView.contentMode = .center
        myImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return myImageView
    }()
    private func setupImageView() {
        hStackView.addArrangedSubview(image)
    }
    
    // MARK: SectionName setup
    
    private lazy var sectionName: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
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
        myImageView.tintColor = .skeletonViewColor
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

extension CollectionsTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
