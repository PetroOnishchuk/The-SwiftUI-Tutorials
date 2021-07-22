//
//  ProjectModel.swift
//  ProjectModel
//
//  Created by Petro Onishchuk on 7/19/21.
//

import SwiftUI

enum UserDefaultsSection: String {
    case state = "UserDefaults & @State"
    case appStorageSimple = "UserDefaults & AppStorage Simple"
    case appStorageAndUD = "UserDefaults & AppStorage"
    case sceneStorageSimple = "UserDefaults and SceneStorage"
    case stateAndCustomObject = "UserDefaults & @State & Custom Object"
    case appStorageAndCustomObject = "@AppStorage & Custom Object"
    case appStorageAndCustomObjectAndUD = "@AppStorage & Custom Object & UD"
}

enum SectionPlaceholder: String {
    case userFirstName = "First Name of User"
    case userSecondName = "Second Name of User"
    case firstUserField = "Field for First Name"
    case secondUserField = "Field for Second Name"
    case enterFirstName = "Enter First Name"
    case enterSecondName = "Enter Second Name"
    case stateFirstName = "@State First Name"
    case stateSecondName = "@State Second Name"
    case stateFirstNameField = "Field for @State First Name"
    case stateSecondNameField = "Field for @State Second Name"
    case buttonSection = "Section for Button"
    case nameOfButton = "Save"
}



struct BasicUser: Codable {
    
    var firstName: String
    var secondName: String
}



struct CustomUser: Codable {
    var firstName: String
    var secondName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case secondName
    }
    
    init(firstName: String, secondName: String) {
        self.firstName = firstName
        self.secondName = secondName
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try values.decode(String.self, forKey: .firstName)
        self.secondName = try values.decode(String.self, forKey: .secondName)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(secondName, forKey: .secondName)
    }
}

extension CustomUser: RawRepresentable {
    
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(CustomUser.self, from: data)
        else { return nil }
        
        self = result
    }
    
    var rawValue: String {
        guard let data = try? JSONEncoder().encode(self), let result = String(data: data, encoding: .utf8)
        else { return "[]" }
        return result
    }
}

