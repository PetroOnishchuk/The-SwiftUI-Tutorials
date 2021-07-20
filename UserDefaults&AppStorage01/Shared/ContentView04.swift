//
//  ContentView04.swift
//  ContentView04
//
//  Created by Petro Onishchuk on 7/19/21.
//

import SwiftUI

struct ContentView04: View {
    
    @AppStorage("firstName04") var firstName = ""
    @AppStorage("secondName04") var secondName = ""
    
    @State var stateFirstName = ""
    @State var stateSecondName = ""
    
    var body: some View {
        List {
            Section(header: Text(SectionPlaceholder.userFirstName.rawValue)) {
                Text(firstName)
            }
            Section(header: Text(SectionPlaceholder.userSecondName.rawValue)) {
                Text(secondName)
            }
            Section(header: Text(SectionPlaceholder.stateFirstName.rawValue)) {
                Text(stateFirstName)
            }
            Section(header: Text(SectionPlaceholder.stateSecondName.rawValue)) {
                Text(stateSecondName)
            }
            Section(header: Text(SectionPlaceholder.stateFirstNameField.rawValue)) {
                TextField(SectionPlaceholder.enterFirstName.rawValue, text: $stateFirstName)
            }
            Section(header: Text(SectionPlaceholder.stateSecondName.rawValue)) {
                TextField(SectionPlaceholder.stateSecondNameField.rawValue, text: $stateSecondName)
            }
            Section(header: Text(SectionPlaceholder.buttonSection.rawValue)) {
                Button(SectionPlaceholder.nameOfButton.rawValue) {
                    UserDefaults.standard.set(stateFirstName, forKey: "firstName04")
                    UserDefaults.standard.set(stateSecondName, forKey: "secondName04")
                }
            }
        }
        .navigationTitle(UserDefaultsSection.appStorageAndUD.rawValue)
    }
}

struct ContentView04_Previews: PreviewProvider {
    static var previews: some View {
        ContentView04()
    }
}
