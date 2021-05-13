//
//  CatFact.swift
//  URLSessionAndCodable01Part2
//
//  Created by Petro Onishchuk on 5/12/21.
//

import Foundation



struct CatFact: Codable {
    var id: String
    var text: String
    var dateUpdated: Date
    var modifiedDateUpdated: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: dateUpdated)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case text
        case dateUpdated = "updatedAt"
    }
}
