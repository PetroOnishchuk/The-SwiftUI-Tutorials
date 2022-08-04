//
//  MessageViewController.swift
//  UIKitAndWebSockets
//
//  Created by Petro Onishchuk on 8/4/22.
//

import UIKit

class MessageViewController: UITabBarController {
    //MARK: Properties of Class
    
    var messagesTableView: UITableView!
    var messageFormAlert: UIAlertController!
    var connectionFormAlert: UIAlertController!
    var allMessages = [Message]()
    var connectionType = WSConnection.golangWSServer
    var webSocket : URLSessionWebSocketTask?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        allMessages.append(Message(id: "Test ID", body: "BodyTest", sender: "SenderTest", senderID: "SenderID Test"))
        
        setupMessagesTableView()
        addBarButtonItems()
        setupConnectionFormAlert()
        setupMessageFormAlert()
      
    }
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
    
    //MARK: Clean Array
    func cleanArray() {
        DispatchQueue.main.async {
            [weak self] in
            self?.allMessages = []
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
