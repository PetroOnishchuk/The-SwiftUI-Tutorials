//
//  ContentView06.swift
//  ContentView06
//
//  Created by Petro Onishchuk on 7/20/21.
//

import SwiftUI

struct ContentView06: View {
    
    @AppStorage("customUser#06") var customUser = CustomUser(firstName: "", secondName: "")
    
    @State var firstName = ""
    @State var secondName = ""
    
    
    var body: some View {
        List {
            Section(header: Text(SectionPlaceholder.userFirstName.rawValue)) {
                Text(customUser.firstName)
            }
            Section(header: Text(SectionPlaceholder.userSecondName.rawValue)) {
                Text(customUser.secondName)
            }
            Section(header: Text(SectionPlaceholder.firstUserField.rawValue)) {
                TextField(SectionPlaceholder.enterFirstName.rawValue, text: $customUser.firstName)
            }
            Section(header: Text(SectionPlaceholder.secondUserField.rawValue)) {
                TextField(SectionPlaceholder.enterSecondName.rawValue, text: $customUser.secondName)
            }
            Section(header: Text(SectionPlaceholder.stateFirstNameField.rawValue)) {
                TextField(SectionPlaceholder.enterFirstName.rawValue, text: $firstName)
            }
            Section(header: Text(SectionPlaceholder.stateSecondNameField.rawValue)) {
                TextField(SectionPlaceholder.enterSecondName.rawValue, text: $secondName)
            }
            Section(header: Text(SectionPlaceholder.buttonSection.rawValue)) {
                Button(SectionPlaceholder.nameOfButton.rawValue) {
                    let newUser = CustomUser(firstName: firstName, secondName: secondName)
                    self.customUser = newUser
                }
            }
        }
        .navigationTitle(Text(UserDefaultsSection.appStorageAndCustomObject.rawValue))
    }
}

struct ContentView06_Previews: PreviewProvider {
    static var previews: some View {
        ContentView06()
    }
}
