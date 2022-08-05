//
//  SetupAlertsExtensions.swift
//  UIKitAndWebSockets
//
//  Created by Petro Onishchuk on 8/4/22.
//

import Foundation
import UIKit

extension MessageViewController {
    
    //MARK:  setupConnectionFormAlert()
    //setup UIAlertController for make WebSocket connections
    func setupConnectionFormAlert() {
        connectionFormAlert = UIAlertController(title: "WS Connection Setting", message: "Select type of WS Connection\n or Close WSConnection", preferredStyle: .alert)
        
        let piesocketWSCAction = UIAlertAction(title: "Piesocket WS Conn", style: .default) {
            [weak self] _ in
            self?.connectionType = .piesocketWSServer
            self?.cleanArray()
            self?.makeConn()
        }
        let golangWSCAction = UIAlertAction(title: "Golang WS Conn", style: .default) {
            [weak self] _ in
            self?.connectionType = .golangWSServer
            self?.cleanArray()
            self?.makeConn()
        }
        
        let disconnectWSCAction = UIAlertAction(title: "Disconnect WS Conn", style: .destructive) {
            [weak self] _ in
            self?.closeSession()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) {_ in
        }
        
        connectionFormAlert.addAction(piesocketWSCAction)
        connectionFormAlert.addAction(golangWSCAction)
        connectionFormAlert.addAction(disconnectWSCAction)
        connectionFormAlert.addAction(cancelAction)
        
    }
    
    //MARK: - messageFormAlert
    //setup UIAlertController for create message for send message through WebSocket Connection
    func setupMessageFormAlert() {
        messageFormAlert = UIAlertController(title: "Create a New Message", message: "Connection Type: \(connectionType.rawValue)", preferredStyle: .alert)
        
        messageFormAlert.addTextField {
            titleTextField in
            titleTextField.placeholder = "Message Body"
        }
        messageFormAlert.addTextField {
            titleTextField in
            titleTextField.placeholder = "SenderValue"
        }
        
        let addAction = UIAlertAction(title: "Send Message", style: .default) {
            [weak self] _ in
            let newMessage = self?.newMessage() ?? Message(id: "", body: "Default Message", sender: "Def Sender", senderID: "Def Sender")
            print("New Message \(newMessage)")
            self?.sendMessageToWSServer(newMessage: newMessage)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) {[weak self] _ in
            self?.messageFormAlert.textFields?[0].text = ""
            self?.messageFormAlert.textFields?[1].text = ""
            
            
        }
        messageFormAlert.addAction(addAction)
        messageFormAlert.addAction(cancelAction)
    }
    
    //func for create a new Message for send to WebSocket Server
    func newMessage() -> Message {
        let bodyText = messageFormAlert.textFields?[0].text ?? "No Body"
        let senderText = messageFormAlert.textFields?[1].text ?? "No Sender"
        let newMessage = Message(id: "", body: bodyText, sender: senderText, senderID: "")
        return newMessage
    }
    
}
