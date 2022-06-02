//
//  Page+UserModel.swift
//  URLSessionGenericAndDatabaseiOS01
//
//  Created by Petro Onishchuk on 6/2/22.
//

import SwiftUI

struct User: Codable, Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case avatar
    }
}

struct Support: Codable {
    let url: String
    let text: String
    
    init() {
        url = ""
        text = ""
    }
    
    init(url: String, text: String) {
        self.url = url
        self.text = text
    }
}

struct Page: Codable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let allUsers: [User]
    let support: Support
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case allUsers = "data"
        case support
    }
    
    init() {
        page = 0
        perPage = 0
        total = 0
        totalPages = 0
        allUsers = []
        support = Support()
    }
    
    init(page: Int, perPage: Int, total: Int, totalPages: Int, allUsers: [User], support: Support) {
        self.page = page
        self.perPage = perPage
        self.total = total
        self.totalPages = totalPages
        self.allUsers = allUsers
        self.support = support
    }
}

enum TypeOfAppURL {
    case getRequestReqresAPI
    case getRequestLocalhostAPI
    case postRequestLocalhostAPI
}

enum TypeOfSearch {
    case multipleSearch
    case singleSearch
    case off
}
enum MyRequestError: Error {
    case invalidURL
    case invalidURLComponents
    case invalidData
    case serverSideErrorWithResponse(Int)
    case invalidHTTPURLResponse
}
