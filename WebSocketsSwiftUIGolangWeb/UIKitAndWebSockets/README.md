# UIKit Project and WebSocket Connections
## UIKit WebSocket Client Project

 Project for work with [Piesocket WebSocket Servers](https://www.piesocket.com/websocket-tester) and also for work with my [Golang WebSocket Servers](https://github.com/PetroOnishchuk/The-SwiftUI-Tutorials/tree/master/WebSocketsSwiftUIGolangWeb).  

  This project work similar like my [SwiftUI WebSocket Client project](https://github.com/PetroOnishchuk/The-SwiftUI-Tutorials/tree/master/WebSocketsSwiftUIGolangWeb/SwiftUIAndWebSockets)  

### Setup rootViewController:
```Swift
        window?.rootViewController = mainNC
```
Code:
```Swift
//
//  SceneDelegate.swift
//  UIKitAndWebSockets
//
//  Created by Petro Onishchuk on 8/4/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowsScene)
        window?.makeKeyAndVisible()
        let messagesVC = MessageViewController()
        let mainNC = UINavigationController(rootViewController: messagesVC)
        window?.rootViewController = mainNC
        
        
    }

```

### Create Properties in MessageViewController() for work with views and data.  

Code:

```Swift
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
    
```
### Create extension of MessageViewController for setup UITableView:
```Swift
 var messagesTableView: UITableView!
```
Code

```Swift
//
//  setupTableViewExtension.swift
//  UIKitAndWebSockets
//
//  Created by Petro Onishchuk on 8/4/22.
//

import UIKit

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: setupMessageTableView()
    //setup constraints for messageTableView
    func setupMessagesTableView() {
        messagesTableView = UITableView()
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        messagesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "messageCell")
        messagesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messagesTableView)
        messagesTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messagesTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        messagesTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        messagesTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    
    //MARK: Implemented  UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMessages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        let message = allMessages[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = message.body
        
        let largeTitle = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        content.image = UIImage(systemName: "message.circle", withConfiguration: largeTitle)
        content.secondaryText = "Sender: \(message.sender).\nSenderID: \(message.senderID)\nID: \(message.id)"
        content.imageProperties.tintColor = .purple
        cell.contentConfiguration = content
        
        return cell
    }
}

```
### Create extension of MessageViewController for setup:
```Swift
    var messageFormAlert: UIAlertController!
    var connectionFormAlert: UIAlertController!
```
Code:
```Swift
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

```
### Create extension of MessageViewController for setup WebSocket Connections.  
```Swift
    var webSocket : URLSessionWebSocketTask?
```
Code:  
```Swift 
//
//  SetupWebSocketExtension.swift
//  UIKitAndWebSockets
//
//  Created by Petro Onishchuk on 8/4/22.
//

import Foundation

extension MessageViewController: URLSessionWebSocketDelegate {
    
    
    //MARK: makeConn() connection
    // func for make WebSocket Connection
    func makeConn() {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        
        let url = makeWsULR()
        webSocket = session.webSocketTask(with: url)
        webSocket?.resume()
    }
    
    //MARK: receive() message
    // func for receive message from WebSocket Server
    func receive() {
        webSocket?.receive(completionHandler: { [weak self]result  in
            switch result {
            case .success(let message):
                
                switch message {
                    
                case .data(let data):
                    print("Data received \(data)")
                case .string(let strMessage):
                    print("String received \(strMessage)")
                    self?.appendToArray(text: strMessage)
                default:
                    break
                }
                
            case .failure(let error):
                print("Error Receiving \(error)")
            }
            // Creates the Recursion
            // for listen again message from WebSocket Server
            self?.receive()
        })
    }
    
    // work with message what we take from WebSocket Server
    func appendToArray(text: String) {
        let dataString = Data(text.utf8)
        switch connectionType {
        case .piesocketWSServer:
            DispatchQueue.main.async {
                [weak self] in
                let newMessage = Message(id: "IDK", body: text, sender: "sender web", senderID: "senderid web")
                self?.allMessages.append(newMessage)
                self?.messagesTableView.reloadData()
            }
        case .golangWSServer:
            do {
                let response = try self.decodeAppObject(decodeType: Message.self, inputData: dataString)
                DispatchQueue.main.async {
                    [weak self] in
                    
                    self?.allMessages.append(response)
                    self?.messagesTableView.reloadData()
                }
            } catch (let decodeError) {
                print("Decode Error: \(decodeError)")
            }
        }
    }
    
    //work with message object before pass to func send(text: string)
    func sendMessageToWSServer(newMessage: Message) {
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
    //MARK: send(text: String)
    // func for send message to WebSocket Server
    func send(text: String){
        print("Send Message")
        self.webSocket?.send(.string(text), completionHandler: { [weak self] error in
            if let error {
                print(" We have Error Message: \(error)")
            }
        })
    }
    
    //MARK: Close Session
    func closeSession(){
        webSocket?.cancel(with: .normalClosure, reason: nil)
        
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
    
    //MARK: MakeURL
    // make url, depend of type of the connectionType
    func makeWsULR() -> URL {
        switch connectionType {
        case .piesocketWSServer:
            let url = URL(string:  "wss://demo.piesocket.com/v3/channel_1?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self")!
            return url
        case .golangWSServer:
            let url = URL(string: "ws://localhost:5000")!
            return url
        }
    }
    
    
    //MARK: Implement URLSessionWebSocketDelegate protocol
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Connected to server successful")
        self.receive()
    }
    
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Disconnect from Server \(String(describing: reason))")
    }
    
}

```
### Completed our MessageViewController().
  
Code:  

```Swift
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

```

