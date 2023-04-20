//
//  ChatManager.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import Foundation
import Starscream

protocol DataProviderDelegate {
    func didReceive(result: Result<MessageModel, Error>)
}

final class ChatManager {
    
    var isConnected: Bool = false
    var delegate: DataProviderDelegate?
    var chatId: String?
    
    lazy var socket: WebSocket? = {
        let url = "ws://107684.web.hosting-russia.ru:8000/api/chats/\(self.chatId ?? "")/messages"
        guard let url = URL(string: url) else {
            print("can not create URL from: \(url)")
            return nil
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(TokenManager.shared.fetchAccessToken())", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 0
        
        var socket = WebSocket(request: request)
        return socket
    }()
    
    func subscribe() {
        self.socket?.delegate = self
        self.socket?.connect()
    }
    
    func unsubscribe() {
        self.socket?.forceDisconnect()
    }
    
    func sendMessage(_ message: String) {
        self.socket?.write(string: message)
    }
    
    deinit {
        print("deinited")
        self.socket?.forceDisconnect()
        self.socket = nil
    }
    
}

// MARK: - WebSocketDelegate

extension ChatManager: WebSocketDelegate {
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
            case .connected(let headers):
                isConnected = true
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                handleText(text: string)
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                isConnected = false
            case .error(let error):
                isConnected = false
                handleError(error: error)
            }
    }
    
    private func handleText(text: String) {
        let jsonData = Data(text.utf8)
        let decoder = JSONDecoder()
        do {
            let resArray = try decoder.decode(MessageModel.self, from: jsonData)
            self.delegate?.didReceive(result: .success(resArray))
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func handleError(error: Error?) {
        print("Error")
        if let e = error {
            self.delegate?.didReceive(result: .failure(e))
        }
    }
}
