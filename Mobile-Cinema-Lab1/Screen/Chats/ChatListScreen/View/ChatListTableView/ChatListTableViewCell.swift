//
//  ChatListTableViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHStackView()
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(chat: ChatModel) {
        self.image.loadImageWithURL(chat.lastMessage?.authorAvatar ?? "")
        self.image.image = self.image.image?.resizeImage(newWidth: 64, newHeight: 64)
        self.chatName.text = chat.chatName
        self.chatLastMessage.text = "\(chat.lastMessage?.authorName ?? ""): \(chat.lastMessage?.text ?? "")"
    }
    
    // MARK: - HStackView setup
    
    private lazy var hStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 16
        myStackView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func setupHStackView() {
        contentView.addSubview(hStackView)
        setupImageView()
        setupChatInfoStack()
        hStackView.snp.makeConstraints { make in
//            make.horizontalEdges.equalToSuperview()
            make.width.equalToSuperview()
//            make.height.equalTo(96)
        }
    }
    
    // MARK: Image setup
    
    private lazy var image: UIImageView = {
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        myImageView.layer.cornerRadius = myImageView.frame.height / 2
        myImageView.clipsToBounds = true
        myImageView.contentMode = .scaleAspectFit
        myImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return myImageView
    }()
    private func setupImageView() {
        hStackView.addArrangedSubview(image)
        image.snp.makeConstraints { make in
            make.height.equalTo(64)
            make.width.equalTo(64)
        }
    }
    
    // MARK: MovieInfoStack setup
    
    private lazy var chatInfoStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.distribution = .equalCentering
        return myStackView
    }()
    private func setupChatInfoStack() {
        hStackView.addArrangedSubview(chatInfoStack)
        chatInfoStack.addArrangedSubview(chatName)
        chatInfoStack.addArrangedSubview(chatLastMessage)
    }
    
    private lazy var chatName: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 14, weight: .bold)
        myLabel.numberOfLines = 1
        myLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        myLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        myLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
//        myLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return myLabel
    }()
    
    private lazy var chatLastMessage: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 14, weight: .regular)
        myLabel.numberOfLines = 3
        myLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        myLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        myLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        myLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return myLabel
    }()
    
}

extension ChatListTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
