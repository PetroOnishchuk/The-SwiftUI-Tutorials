//
//  MessageViewController.swift
//  UIKitAndWebSockets
//
//  Created by Petro Onishchuk on 8/4/22.
//

import UIKit

class MessageViewController: UITabBarController {
    
    //MARK: Properties for work with views and data
    var messagesTableView: UITableView!
    var messageFormAlert: UIAlertController!
    var connectionFormAlert: UIAlertController!
    var allMessages = [Message]()
    var connectionType = WSConnection.golangWSServer
    var webSocket : URLSessionWebSocketTask?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WebSocket Client & UIKit"
        // placeholder message for messagesTableView
        allMessages.append(Message(id: "Test ID", body: "BodyTest", sender: "SenderTest", senderID: "SenderID Test"))
        
        //MARK: Run all our functions for setup project
        setupMessagesTableView()
        setupConnectionFormAlert()
        setupMessageFormAlert()
        addBarButtonItems()
        
    }
    //MARK: AddBarButtonItems()
    func addBarButtonItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAlert))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "WS Conn", style: .plain, target: self, action: #selector(presentWSConnAlert))
    }
    @objc func presentAlert() {
        present(messageFormAlert, animated: true)
    }
    @objc func presentWSConnAlert() {
        present(connectionFormAlert, animated: true)
    }
    
    //MARK: Clean allMessages Array
    func cleanArray() {
        DispatchQueue.main.async {
            [weak self] in
            self?.allMessages = []
        }
    }
    
}
