//
//  Page+UserModel.swift
//  URLSessionAndGETRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/12/22.
//

import Foundation
import SwiftUI

struct User: Codable, Identifiable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

struct Support: Codable {
    let url: String
    let text: String
}


struct AllUserData: Codable {
    let user: User
    let support: Support
    
    enum CodingKeys: String, CodingKey {
        case user = "data"
        case support
    }
}

struct Page: Codable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    var allUsers: [User]
    let support: Support
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case allUsers = "data"
        case support
    }
}

enum MyRequestError: Error {
    case invalidURL
    case invalidData
    case serverSideErrorWithResponse(Int)
    case invalidHTTPURLResponse
}
