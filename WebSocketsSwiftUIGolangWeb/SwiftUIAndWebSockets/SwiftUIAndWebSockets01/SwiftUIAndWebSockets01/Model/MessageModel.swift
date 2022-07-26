//
//  MessageModel.swift
//  SwiftUIAndWebSockets01
//
//  Created by Petro Onishchuk on 7/25/22.
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
