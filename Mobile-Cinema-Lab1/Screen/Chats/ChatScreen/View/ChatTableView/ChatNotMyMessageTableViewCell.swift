//
//  ChatNotMyMessageTableViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import UIKit
import SnapKit
import Kingfisher

class ChatNotMyMessageTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(message: MessageModel, bottomSpacing: CGFloat, hideAvatar: Bool = false) {
        self.messageLabel.text = message.text
        self.senderNameLabel.text = message.authorName
        self.messageTimeLabel.text = " • \(IsoTimeToHHMMUseCase().convertToTime(message.creationDateTime)!)"
        blankView.snp.remakeConstraints { make in
            make.top.equalTo(messageBackgroundView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-bottomSpacing)
        }
        guard !hideAvatar else {
            userAvatarImageView.alpha = .zero
            return
        }
        if(message.authorAvatar == nil) {
            self.userAvatarImageView.image = R.image.userAvatar()
            self.userAvatarImageView.alpha = 1
        }
        else {
            self.userAvatarImageView.loadImageWithURL(message.authorAvatar ?? "", contentMode: .scaleAspectFill)
            self.userAvatarImageView.alpha = 1
        }
    }
    
    private func setupSubviews() {
        setupMessageView()
    }
    
    // MARK: - MessageView setup
    
    private lazy var messageView: UIView = {
        let myView = UIView()
        return myView
    }()
    private func setupMessageView() {
        contentView.addSubview(messageView)
        setupMessageBackgroundView()
        setupUserAvatarImageView()
        setupBlankView()
        messageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview().inset(56)
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - MessageBackgroundView setup
    
    private lazy var messageBackgroundView: UIView = {
        let myView = UIView()
        myView.backgroundColor = .chatElementBackground
        myView.layer.cornerRadius = 8
        myView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        myView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return myView
    }()
    private func setupMessageBackgroundView() {
        messageView.addSubview(messageBackgroundView)
        setupMessageLabel()
        setupSenderInfoStack()
        messageBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: - MessageLabel setup
    
    private lazy var messageLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 14, weight: .regular)
        myLabel.numberOfLines = 0
        myLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return myLabel
    }()
    private func setupMessageLabel() {
        messageBackgroundView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(12)
        }
    }
    
    // MARK: - SenderInfoStack setup
    
    private lazy var senderInfoStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 0
        return myStackView
    }()
    private func setupSenderInfoStack() {
        messageBackgroundView.addSubview(senderInfoStack)
        setupSenderNameLabel()
        setupMessageTimeLabel()
        senderInfoStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-4)
            make.top.equalTo(messageLabel.snp.bottom).offset(4)
        }
    }
    
    // MARK: - SenderNameLabel setup
    
    private lazy var senderNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 1
        myLabel.textColor = .notMyMessageInfoColor
        myLabel.font = .systemFont(ofSize: 12, weight: .regular)
        myLabel.textAlignment = .right
        return myLabel
    }()
    private func setupSenderNameLabel() {
        senderInfoStack.addArrangedSubview(senderNameLabel)
    }
    
    // MARK: - MessageTimeLabel setup
    
    private lazy var messageTimeLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 1
        myLabel.textColor = .notMyMessageInfoColor
        myLabel.font = .systemFont(ofSize: 12, weight: .regular)
        myLabel.textAlignment = .right
        myLabel.setContentHuggingPriority(.required, for: .horizontal)
        myLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        return myLabel
    }()
    private func setupMessageTimeLabel() {
        senderInfoStack.addArrangedSubview(messageTimeLabel)
    }
    
    // MARK: - UserAvatarImageView setup
    
    private lazy var userAvatarImageView: UIImageView = {
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        
        myImageView.layer.cornerRadius = myImageView.frame.height / 2
        myImageView.clipsToBounds = true
        myImageView.contentMode = .scaleAspectFill
        return myImageView
    }()
    private func setupUserAvatarImageView() {
        messageView.addSubview(userAvatarImageView)
        userAvatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.trailing.equalTo(messageBackgroundView.snp.leading).inset(-8)
            make.bottom.equalTo(messageBackgroundView.snp.bottom)
            make.leading.equalToSuperview()
        }
    }
    
    // MARK: - BlankView setup
    
    private lazy var blankView: UIView = {
        let myView = UIView()
        myView.backgroundColor = .purple
        return myView
    }()
    private func setupBlankView() {
        messageView.addSubview(blankView)
    }
    
}

extension ChatNotMyMessageTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
