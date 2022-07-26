//
//  PiesocketVM.swift
//  SwiftUIAndWebSockets01
//
//  Created by Petro Onishchuk on 7/25/22.
//

import Foundation
import SwiftUI

class PiesocketVM: ObservableObject {
    private var webSocketTask: URLSessionWebSocketTask?
    @Published var allMessages = [Message]()
    
    //MARK: Clean allMessages
    @MainActor
    func cleanAllMessages() {
        allMessages = []
    }
    
    //MARK: Connection
    func connect() {
        let url = URL(string: "wss://demo.piesocket.com/v3/channel_1?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self")!
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.receive(completionHandler: onReceive(incoming:))
        webSocketTask?.resume()
    }
    
    
    //MARK: onReceive
    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
        webSocketTask?.receive(completionHandler: onReceive(incoming:))
        if case .success(let message) = incoming {
            if case .string(let text) = message {
                print("Receive Message: \(text)")
                let newMessage = Message(id: UUID().uuidString, body: text, sender: "demo.piesocket", senderID: "API")
                DispatchQueue.main.async { [weak self] in
                    self?.allMessages.append(newMessage)
                }
            }
        }else if case .failure(let error) = incoming {
            print("Error", error)
        }
    }
    
    
  //MARK:   Disconnect
    func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
    
    deinit {
        disconnect()
    }
    
    //MARK: Send
    func send(text: String) {
        webSocketTask?.send(.string(text), completionHandler: { error in
            if let error {
                print("Error sending message", error)
            }
        })
    }
    
    
}
