//
//  ChatScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import UIKit
import RswiftResources

class ChatScreenViewController: UIViewController, ChatUpdateProtocol {

    var viewModel: ChatScreenViewModel!
    
    override func loadView() {
        let chatScreenView = ChatScreenView(viewModel: self.viewModel)
        view = chatScreenView
        view.backgroundColor = R.color.backgroundColor()
        self.setupNavigationBarAppearence()
        self.title = self.viewModel.chat?.chatName ?? R.string.chatScreenStrings.default_chat_name()
        self.navigationItem.leftBarButtonItem = getNavigationLeftItem()
        chatScreenView.connectToWebSocket()
        chatScreenView.getUserId()
        chatScreenView.updateChat()
    }
    
    private func getNavigationLeftItem() -> UIBarButtonItem {
        let backItem = UIBarButtonItem(image: R.image.backArrow(), style: .plain, target: self, action: #selector(goBackToChatListScreen))
        backItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        backItem.tintColor = .white
        return backItem
    }
    @objc private func goBackToChatListScreen() {
        self.viewModel.goToPreviousScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateChat() {
        if let myView = view as? ChatScreenView {
            myView.updateChat()
        }
    }

}

extension UIViewController {
    func setupNavigationBarAppearence() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let navigationBarTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
            .foregroundColor: UIColor.white
        ]
        if let navBarAppearance = navigationController?.navigationBar.standardAppearance {
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = R.color.backgroundColor()
            navBarAppearance.titleTextAttributes = navigationBarTitleAttributes
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
}
