//
//  MyAppModel.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 12/28/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
struct User: Hashable, Codable {
    @DocumentID var id: String?
    var firstName: String
    var lastName: String
    var email: String
    @ServerTimestamp var lastUpdated: Timestamp?
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case email
        case lastUpdated
        
        
    }
    init(firstName: String, lastName: String, email: String, lastUpdated: Timestamp? = nil) {
        self.firstName = firstName
        self.lastName  = lastName
        self.email = email
        self.lastUpdated = lastUpdated
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        email = try values.decode(String.self, forKey: .email)
        do {
            lastUpdated = try values.decode(Timestamp.self, forKey: .lastUpdated)
        } catch {
            lastUpdated = nil
        }
        
    }
}
//@ServerTimestamp var lastUpdated: Timestamp?
struct CustomAlertInfo {
    var title: String
    var description: String
}

struct Task: Hashable, Identifiable, Codable {
    @DocumentID var id: String?
    var text: String
    var dateCreated: Date
    var isCompleted: Bool
    var lastUpdated: Date?
}

