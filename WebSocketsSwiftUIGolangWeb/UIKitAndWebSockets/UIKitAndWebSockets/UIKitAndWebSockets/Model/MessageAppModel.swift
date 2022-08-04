//
//  MessageAppModel.swift
//  UIKitAndWebSockets
//
//  Created by Petro Onishchuk on 8/4/22.
//

import Foundation

struct Message: Codable, Identifiable {
    let id: String
    let body: String
    let sender: String
    let senderID: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case body
        case sender
        case senderID = "senderid"
    }
}

enum WSConnection: String {
    case piesocketWSServer
    case golangWSServer
}
