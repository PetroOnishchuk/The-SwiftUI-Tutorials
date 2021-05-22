//
//  User.swift
//  URLSessionAndPOSTRequest01
//
//  Created by Petro Onishchuk on 5/15/21.
//

import Foundation



struct User: Codable {
    var name: String
    var job: String
    var id: String?
    var dateCreated: Date?
    
    var realID: String {
        if let newID = id {
            return newID
        } else {
            return "******"
        }
    }
    
    var modifiedDateCreated: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        if let newDate = dateFormatter.string(from: new)
    }
}
