//
//  ChatMessageTableViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import UIKit
import SnapKit
import Kingfisher
import RswiftResources

enum MessageType {
    case myMessage
    case notMyMessage
}

final class ChatMessageTableViewCell: UITableViewCell {

    private var messageType: MessageType = .myMessage

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(messageType: MessageType, message: MessageModel, bottomSpacing: CGFloat, hideAvatar: Bool = false) {
        self.messageLabel.text = message.text
        self.senderNameLabel.text = message.authorName
        self.messageTimeLabel.text = " • \(IsoTimeToHHMMUseCase().convertToTime(message.creationDateTime)!)"
        blankView.snp.remakeConstraints { make in
            make.top.equalTo(messageBackgroundView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-bottomSpacing)
        }
        self.messageType = messageType
        configureMessageType(messageType: messageType)

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

    private func configureMessageType(messageType: MessageType) {
        messageBackgroundView.layer.maskedCorners = maskedCorners
        messageBackgroundView.backgroundColor = messageBackgroundViewColor
        senderNameLabel.textColor = senderNameLabelTextColor
        messageTimeLabel.textColor = messageTimeLabelTextColor

        setupMessageViewConstraints()
        setupMessageBackgroundViewConstraints()
        setupSenderInfoStackConstraints()
        setupUserAvatarImageViewConstraints()
    }

    private func setupSubviews() {
        setupMessageView()
    }

    // MARK: - MessageView setup

    private lazy var messageView: UIView = {
        let myView = UIView()
        myView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return myView
    }()
    private func setupMessageView() {
        contentView.addSubview(messageView)
        setupMessageBackgroundView()
        setupUserAvatarImageView()
        setupBlankView()
    }

    // MARK: - MessageBackgroundView setup

    private lazy var messageBackgroundView: UIView = {
        let myView = UIView()
        myView.layer.cornerRadius = 8
        myView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return myView
    }()
    private func setupMessageBackgroundView() {
        messageView.addSubview(messageBackgroundView)
        setupMessageLabel()
        setupSenderInfoStack()
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
    }

    // MARK: - SenderNameLabel setup

    private lazy var senderNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 1
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

// MARK: - ReusableView

extension ChatMessageTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

private extension ChatMessageTableViewCell {
    var maskedCorners: CACornerMask {
        switch messageType {
        case .myMessage:
            return [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
        case .notMyMessage:
            return [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
    }

    var messageBackgroundViewColor: UIColor {
        switch messageType {
        case .myMessage:
            return .redColor
        case .notMyMessage:
            return .chatElementBackground
        }
    }

    var senderNameLabelTextColor: UIColor {
        switch messageType {
        case .myMessage:
            return .myMessageSenderColor
        case .notMyMessage:
            return .notMyMessageInfoColor
        }
    }

    var messageTimeLabelTextColor: UIColor {
        switch messageType {
        case .myMessage:
            return .myMessageSenderColor
        case .notMyMessage:
            return .notMyMessageInfoColor
        }
    }

    func setupMessageViewConstraints() {
        messageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            switch messageType {
            case .myMessage:
                make.leading.greaterThanOrEqualToSuperview().inset(56)
                make.trailing.equalToSuperview().inset(16)
            case .notMyMessage:
                make.trailing.lessThanOrEqualToSuperview().inset(56)
                make.leading.equalToSuperview().inset(16)
            }
        }
    }

    func setupMessageBackgroundViewConstraints() {
        messageBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            switch messageType {
            case .myMessage:
                make.leading.equalToSuperview()
            case .notMyMessage:
                make.trailing.equalToSuperview()
            }
        }
    }

    func setupSenderInfoStackConstraints() {
        senderInfoStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-4)
            make.top.equalTo(messageLabel.snp.bottom).offset(4)
            switch messageType {
            case .myMessage:
                make.trailing.equalToSuperview().inset(16)
                make.leading.greaterThanOrEqualToSuperview().inset(16)
            case .notMyMessage:
                make.trailing.lessThanOrEqualToSuperview().inset(16)
                make.leading.equalToSuperview().inset(16)
            }
        }
    }

    func setupUserAvatarImageViewConstraints() {
        userAvatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.bottom.equalTo(messageBackgroundView.snp.bottom)
            switch messageType {
            case .myMessage:
                make.trailing.equalToSuperview()
                make.leading.equalTo(messageBackgroundView.snp.trailing).offset(8)
            case .notMyMessage:
                make.trailing.equalTo(messageBackgroundView.snp.leading).inset(-8)
                make.leading.equalToSuperview()
            }
        }
    }
}
