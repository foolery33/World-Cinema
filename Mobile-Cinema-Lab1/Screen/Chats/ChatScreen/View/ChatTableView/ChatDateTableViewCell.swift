//
//  ChatDateTableViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import UIKit
import SnapKit

class ChatDateTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupDateLabel()
    }
    
    func setup(date: String) {
        self.dateLabel.text = GetDayAndMonthFromStringDateUseCase().formatDate(date)
        dateLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().inset(UIEdgeInsets(top: 7, left: 0, bottom: 7, right: 0))
            make.width.equalTo(CGFloat(self.dateLabel.text?.calculateLabelSize(font: self.dateLabel.font, widthInset: 32, heightInset: 14).width ?? 0))
            make.height.equalTo(CGFloat(self.dateLabel.text?.calculateLabelSize(font: self.dateLabel.font, widthInset: 32, heightInset: 14).height ?? 0))
        }
    }
    
    private lazy var dateLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 14, weight: .regular)
        myLabel.numberOfLines = 1
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .chatElementBackground
        myLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        myLabel.layer.cornerRadius = 8
        myLabel.layer.masksToBounds = true
        return myLabel
    }()
    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
    }
    
}

extension ChatDateTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
