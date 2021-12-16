//
//  UserViewModel.swift
//  Alert&SwiftUI01
//
//  Created by Petro Onishchuk on 12/14/21.
//

import SwiftUI



class UserViewModel: ObservableObject {
    @Published var listOfUsers = [User]()
    
    
    func appendNewUser(_ user: User) {
        listOfUsers.append(user)
    }
    
    func cleanNameAndSymbol(name: Binding<String>, symbol: Binding<String>) {
        name.wrappedValue = ""
       // name.wrappedValue = ""
        symbol.wrappedValue = ""
    }
}
