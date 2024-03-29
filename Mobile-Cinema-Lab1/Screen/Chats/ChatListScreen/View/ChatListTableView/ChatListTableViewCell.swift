//
//  ChatListTableViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import UIKit
import SnapKit
import SkeletonView

class ChatListTableViewCell: UITableViewCell {

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
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16))
    }
    
    func setup(chat: ChatModel) {
        self.undoneSkeletonView()
        
        self.letters.text = GetFirstTwoLettersOfChatNameUseCase().getLetters(chatName: chat.chatName)
        self.chatNameLabel.text = chat.chatName
        
        let attributedString = NSMutableAttributedString(string: "\(chat.lastMessage?.authorName ?? ""): ", attributes: [NSAttributedString.Key.foregroundColor: R.color.grayTextColor() ?? R.color.grayTextColor() ?? UIColor.grayTextColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
        attributedString.append(NSAttributedString(string: (chat.lastMessage?.text ?? ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)]))
        self.chatLastMessageLabel.attributedText = attributedString
    }
    
    // MARK: - HStackView setup
    
    private lazy var hStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.alignment = .center
        myStackView.axis = .horizontal
        myStackView.spacing = 16
        return myStackView
    }()
    private func setupHStackView() {
        contentView.addSubview(hStackView)
        setupChatPicture()
        setupChatInfoStack()
        setupSeparatingLine()
        hStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - ChatPicture setup
    
    private lazy var chatPicture: UIView = {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        myView.isSkeletonable = true
        myView.layer.cornerRadius = myView.frame.height / 2
        myView.clipsToBounds = true
        myView.backgroundColor = .redColor
        myView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return myView
    }()
    private func setupChatPicture() {
        hStackView.addArrangedSubview(chatPicture)
        setupLetters()
        chatPicture.snp.makeConstraints { make in
            make.height.width.equalTo(64)
        }
    }
    
    // MARK: - Letters setup
    
    private lazy var letters: UILabel = {
        let myLabel = UILabel()
        myLabel.font = .systemFont(ofSize: 24, weight: .bold)
        myLabel.textColor = .white
        myLabel.numberOfLines = 1
        return myLabel
    }()
    private func setupLetters() {
        chatPicture.addSubview(letters)
        letters.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: MovieInfoStack setup
    
    private lazy var chatInfoStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.axis = .vertical
        myStackView.spacing = 15
        return myStackView
    }()
    private func setupChatInfoStack() {
        hStackView.addArrangedSubview(chatInfoStack)
        chatInfoStack.addArrangedSubview(chatNameLabel)
        setupChatLastMessageEmbeddingStack()
    }
    
    // MARK: - ChatNameLabel setup
    
    private lazy var chatNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 14, weight: .bold)
        myLabel.numberOfLines = 1
        myLabel.skeletonTextNumberOfLines = 1
        myLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return myLabel
    }()
    
    // MARK: - ChatLastMessageEmbeddingStack setup
    
    private lazy var chatLastMessageEmbeddingStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.isSkeletonable = true
        myStackView.alignment = .top
        myStackView.axis = .horizontal
        return myStackView
    }()
    private func setupChatLastMessageEmbeddingStack() {
        chatInfoStack.addArrangedSubview(chatLastMessageEmbeddingStack)
        chatLastMessageEmbeddingStack.addArrangedSubview(chatLastMessageLabel)
    }
    
    // MARK: - ChatLastMessageLabel setup
    
    private lazy var chatLastMessageLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.isSkeletonable = true
        myLabel.numberOfLines = 2
        myLabel.skeletonTextNumberOfLines = 2
        myLabel.skeletonLineSpacing = 5
        myLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        return myLabel
    }()
    
    // MARK: - SeparatingLine setup
    
    private lazy var separatingLine: UIView = {
        let myView = UIView()
        myView.isSkeletonable = true
        myView.backgroundColor = .darkGrayColor
        return myView
    }()
    private func setupSeparatingLine() {
        contentView.addSubview(separatingLine)
        separatingLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(chatInfoStack.snp.leading)
            make.trailing.equalTo(chatInfoStack.snp.trailing)
            make.bottom.equalToSuperview()
        }
    }
    
    private func undoneSkeletonView() {
        self.hStackView.alignment = .top
        self.chatInfoStack.spacing = 4
    }
    
}

extension ChatListTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
