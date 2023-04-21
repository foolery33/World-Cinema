//
//  ChatScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import UIKit
import SnapKit

class ChatScreenView: UIView {
    
    var viewModel: ChatScreenViewModel
    
    var maxEstimatedHeight: CGFloat = 0
    
    init(viewModel: ChatScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupSubviews()
        addKeyboardDidmiss()
        setupActivityIndicator(withBackground: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupChatTableView()
        setupMessageTextField()
        setupSendButton()
    }
    
    // MARK: - ChatTableView setup
    
    lazy var chatTableView: ChatTableView = {
        let myTableView = ChatTableView()
        myTableView.viewModel = self.viewModel
        return myTableView
    }()
    private func setupChatTableView() {
        addSubview(chatTableView)
    }
    
    // MARK: - MessageTextField setup

    private lazy var messageTextField: UITextView = {
        let myTextView = UITextView()
        myTextView.delegate = self
        myTextView.text = R.string.chatScreenStrings.type_message()
        myTextView.font = .systemFont(ofSize: 14, weight: .regular)
        myTextView.textColor = .grayColor
        myTextView.isScrollEnabled = false
        myTextView.layer.borderColor = R.color.darkGrayColor()?.cgColor
        myTextView.layer.backgroundColor = UIColor.purple.cgColor
        myTextView.layer.borderWidth = 1
        myTextView.layer.cornerRadius = 5
        myTextView.backgroundColor = .clear
        myTextView.showsVerticalScrollIndicator = false
        myTextView.showsHorizontalScrollIndicator = false
        myTextView.textContainer.heightTracksTextView = true
        myTextView.textContainerInset = UIEdgeInsets(top: 7, left: 16, bottom: 7, right: 16)
        return myTextView
    }()
    private func setupMessageTextField() {
        addSubview(messageTextField)
        messageTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-29)
            make.height.equalTo(messageTextField.sizeThatFits(CGSize(width: messageTextField.frame.size.width, height: .infinity)))
        }
    }
    
    // MARK: - SendButton setup
    
    private lazy var sendButton: UIButton = {
        let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        myButton.layer.cornerRadius = myButton.frame.height / 2
        myButton.clipsToBounds = true
        myButton.backgroundColor = .redColor
        myButton.setImage(R.image.arrowUp(), for: .normal)
        myButton.addImagePressedEffect()
        myButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return myButton
    }()
    @objc private func sendMessage() {
//         Если цвет текста белый => значит, поле пустое. Там placeholder "Напишите сообщение"
        self.viewModel.sendMessage(self.messageTextField.textColor == .white ? self.messageTextField.text ?? "" : "") { success in
            if success {
                self.messageTextField.text = ""
            }
            else {
                self.showAlert(title: R.string.chatScreenStrings.send_message_error(), message: self.viewModel.error)
            }
        }
    }
    private func setupSendButton() {
        addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.leading.equalTo(messageTextField.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-29)
            make.height.width.equalTo(32)
        }
    }
    
    // MARK: Keyboard dismiss
    
    func addKeyboardDidmiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    @objc
    func dismissKeyboard() {
        self.endEditing(true)
    }
    
    func connectToWebSocket() {
        self.viewModel.subscribe(chat: self.viewModel.chat ?? ChatModel(chatId: "", chatName: ""))
    }
    
    func updateChat() {
        if !self.viewModel.messages.isEmpty {
            stopActivityIndicator()
            self.chatTableView.reloadData()
            self.chatTableView.snp.remakeConstraints { make in
                make.top.horizontalEdges.equalToSuperview()
                make.bottom.equalTo(messageTextField.snp.top).offset(-8)
            }
            DispatchQueue.main.async {
                self.chatTableView.scrollToRow(at: IndexPath(row: self.viewModel.dateIndicies.count - 1, section: 0), at: .bottom, animated: true)
            }
        }
    }
    
    func getUserId() {
        self.viewModel.getUserId { success in
            if(!success) {
                self.showAlert(title: R.string.chatScreenStrings.preparation_error(), message: self.viewModel.error)
            }
        }
    }
    
}

extension ChatScreenView: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        let textViewMinHeight = textView.text.calculateLabelSize(font: textView.font!, widthInset: 32, heightInset: 14).height
        let textViewMaxHeight = textView.text.calculateLabelSize(font: textView.font!, widthInset: 32, heightInset: 0).height * 3 + 2 * 7 + 10
        
        print(textViewMinHeight)
        print(textViewMaxHeight)
        print(estimatedSize.height)
        print(maxEstimatedHeight)
        print()
        
        guard estimatedSize.height <= textViewMaxHeight else {
            textView.isScrollEnabled = true
            return
        }
        
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                // Disable the scroll
                textView.isScrollEnabled = false
                if estimatedSize.height < textViewMinHeight {
                    constraint.constant = textViewMinHeight
                } else {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == R.string.chatScreenStrings.type_message() {
            textView.text = ""
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = R.string.chatScreenStrings.type_message()
            textView.textColor = .grayColor
        }
        textViewDidChange(textView)
    }
    
}
