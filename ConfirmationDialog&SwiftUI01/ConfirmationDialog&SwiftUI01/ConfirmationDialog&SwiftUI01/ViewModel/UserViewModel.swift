//
//  UserViewModel.swift
//  ConfirmationDialog&SwiftUI01
//
//  Created by Petro Onishchuk on 12/18/21.
//

import SwiftUI


class UserViewModel: ObservableObject {
    @Published var listOfUsers = [User]()
    
    func appendNewUser(_ user: User) {
        listOfUsers.append(user)
    }
    
    func cleanUsersFields(name: Binding<String>, symbol: Binding<String>, newUser: Binding<User?>) {
        name.wrappedValue = ""
        symbol.wrappedValue = ""
        newUser.wrappedValue = nil
    }
}
