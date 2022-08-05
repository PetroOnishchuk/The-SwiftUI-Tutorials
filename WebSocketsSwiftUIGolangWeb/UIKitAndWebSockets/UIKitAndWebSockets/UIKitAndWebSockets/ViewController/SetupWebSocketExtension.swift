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
