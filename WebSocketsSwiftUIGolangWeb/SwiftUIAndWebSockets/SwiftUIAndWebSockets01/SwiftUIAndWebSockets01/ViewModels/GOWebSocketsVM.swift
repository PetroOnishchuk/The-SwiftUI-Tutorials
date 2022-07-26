//
//  GOWebSocketsVM.swift
//  SwiftUIAndWebSockets01
//
//  Created by Petro Onishchuk on 7/26/22.
//

import Foundation
import SwiftUI

class GOWebSocketsVM: ObservableObject {
    private var webSocketTask: URLSessionWebSocketTask?
    @Published var messageText: String = ""
    @Published var messageSender: String = ""
    @Published var allMessages = [Message]()
    
    
    
    //MARK: Clean All Messages
    @MainActor
    func cleanAllMessages() {
        allMessages = []
    }
    
    //MARK: Clean TextFields
    func cleanTextFields() {
        messageText = ""
        messageSender = ""
        
    }
    
    func makeTrimming(item: String) -> String {
        return item.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func checkNewMessageFields() -> Bool {
        return messageText.isEmpty && messageSender.isEmpty
    }
    
    func createNewMessage() -> Message {
        let newMessageText = makeTrimming(item: messageText)
        let newMessageSender = makeTrimming(item: messageSender)
        let newMessage = Message(id: "", body: newMessageText, sender: newMessageSender, senderID: "")
        
        return newMessage
    }
    
    //MARK: DecodeAppObject
    func decodeAppObject<T: Codable>(decodeType: T.Type, inputData: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            let receiveMessage = try decoder.decode(T.self, from: inputData)
            return receiveMessage
            
        } catch( let decodeError) {
            throw decodeError
        }
    }
    
    //MARK: EncodeAppObject
    func encodeAppObject(data: some Codable) -> Data? {
        do {
            let encoder = JSONEncoder()
            let encodeData = try encoder.encode(data)
            return encodeData
            
        } catch (let encodeError) {
            print("Encode Error \(encodeError)")
        }
        return nil
    }
    
    
    //MARK: START WebSocket Section
    
    //MARK: Connect to WebSocket
    func connect() {
        let url = URL(string: "ws://localhost:5000")!
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.receive(completionHandler: onReceive(incoming:))
        webSocketTask?.resume()
        
    }
    
    //MARK: onReceive
    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
        webSocketTask?.receive(completionHandler: onReceive(incoming:))
        if case .success(let message) = incoming {
            if case .string(let text) = message {
                let dataString = Data(text.utf8)
                do {
                    let response = try decodeAppObject(decodeType: Message.self, inputData: dataString)
                    DispatchQueue.main.async {
                        [weak self] in
                        self?.allMessages.append(response)
                    }
                } catch (let decodeError) {
                    print("Decode Error: \(decodeError)")
                }
            }
        } else if case .failure(let error) = incoming {
            print("Error: \(error)")
        }
    }
    
    //MARK: Check WSConnection
    func checkWSConnection() {
        webSocketTask?.sendPing(pongReceiveHandler: { error in
            if let error {
                print("Error with PING: \(error)")
            }
            
        })
    }
    
    //MARK: Send Message with WS
    func send(text: String) {
        webSocketTask?.send(.string(text), completionHandler: { [weak self] error in
            if let error {
                print("Error with sending message", error)
                
                self?.checkWSConnection()
            }
        })
    }
    
    //MARK: Send Message to GO WS Server
    func sendMessageToGOWSServer() {
        let newMessage = createNewMessage()
        guard let encodeData = encodeAppObject(data: newMessage) else {
            print("Error with Encode String")
            return
        }
        guard let stringData = String(data: encodeData, encoding: .utf8) else {
            print("Error with Encode String")
            return
        }
        send(text: stringData)
    }
    
    //MARK: Disconnect WEBSocket Connection
    func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
    
    deinit {
        disconnect()
    }
}
