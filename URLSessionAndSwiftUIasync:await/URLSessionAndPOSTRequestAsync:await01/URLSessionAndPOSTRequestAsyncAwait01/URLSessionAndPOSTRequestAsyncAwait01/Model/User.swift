//
//  User.swift
//  URLSessionAndPOSTRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/16/22.
//

import Foundation
import SwiftUI

struct UserForm: Codable {
    var name: String
    var job: String
}

struct User: Codable {
    var name: String
    var job: String
    var id: String
    var dateCreated: Date?
    
    var modifiedDateCreated: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        if let newDate = dateCreated {
            return dateFormatter.string(from: newDate)
        } else {
            return "N/A"
        }
    }
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case job
        case id
        case dateCreated = "createdAt"
    }
}

enum MyRequestError: Error {
    case invalidURL
    case invalidURLComponents
    case invalidData
    case serverSideErrorWithResponse(Int)
    case invalidHTTPURLResponse
}
