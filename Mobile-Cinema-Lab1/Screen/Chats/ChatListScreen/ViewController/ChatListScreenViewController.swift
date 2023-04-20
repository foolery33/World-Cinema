//
//  ChatListScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import UIKit

class ChatListScreenViewController: UIViewController {

    var viewModel: ChatListScreenViewModel!
    
    override func loadView() {
        let chatListScreenView = ChatListScreenView(viewModel: self.viewModel)
        view = chatListScreenView
        chatListScreenView.loadChatList()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        self.setupNavigationBarAppearence()
        self.title = "Обсуждения"
        self.navigationItem.leftBarButtonItem = getNavigationLeftItem()
    }
    
    private func getNavigationLeftItem() -> UIBarButtonItem {
        let backItem = UIBarButtonItem(image: UIImage(named: "BackArrow"), style: .plain, target: self, action: #selector(goBackToCreateCollectionScreen))
        backItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        backItem.tintColor = .white
        return backItem
    }
    @objc private func goBackToCreateCollectionScreen() {
        print("go back")
        self.viewModel.goBackToProfileScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
