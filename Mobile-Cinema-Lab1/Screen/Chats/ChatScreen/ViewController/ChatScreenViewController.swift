//
//  ChatScreenViewController.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 14.04.2023.
//

import UIKit

class ChatScreenViewController: UIViewController, ChatUpdateProtocol {

    var viewModel: ChatScreenViewModel!
    
    override func loadView() {
        let chatScreenView = ChatScreenView(viewModel: self.viewModel)
        view = chatScreenView
        self.title = self.viewModel.chat?.chatName ?? "Some chat"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        self.navigationItem.leftBarButtonItem = getNavigationLeftItem()
        chatScreenView.connectToWebSocket()
        chatScreenView.getUserId()
        chatScreenView.updateChat()
    }
    
    private func getNavigationLeftItem() -> UIBarButtonItem {
        let backItem = UIBarButtonItem(image: UIImage(named: "BackArrow"), style: .plain, target: self, action: #selector(goBackToCreateCollectionScreen))
        backItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        backItem.tintColor = .white
        return backItem
    }
    @objc private func goBackToCreateCollectionScreen() {
        print("go back")
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
