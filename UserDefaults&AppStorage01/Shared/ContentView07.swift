//
//  ContentView07.swift
//  ContentView07
//
//  Created by Petro Onishchuk on 7/20/21.
//

import SwiftUI

struct ContentView07: View {
    
    @AppStorage("customUser#07") var customUser = CustomUser(firstName: "", secondName: "")
    
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
            Section(header: Text(SectionPlaceholder.stateFirstNameField.rawValue)) {
                TextField(SectionPlaceholder.enterFirstName.rawValue, text: $firstName)
            }
            Section(header: Text(SectionPlaceholder.stateSecondNameField.rawValue)) {
                TextField(SectionPlaceholder.stateSecondNameField.rawValue, text: $secondName)
            }
            Section(header: Text(SectionPlaceholder.buttonSection.rawValue)) {
                Button(SectionPlaceholder.nameOfButton.rawValue) {
                    let newUser = CustomUser(firstName: firstName, secondName: secondName)
                    guard let encodeData = try? JSONEncoder().encode(newUser) else { return }
                    UserDefaults.standard.set(encodeData, forKey: "customUser#07")
                    
                    guard let data = UserDefaults.standard.data(forKey: "customUser#07"), let userObject = try? JSONDecoder().decode(CustomUser.self, from: data) else { return }
                    customUser = userObject
                }
            }
        }
        .navigationTitle(UserDefaultsSection.appStorageAndCustomObjectAndUD.rawValue)
        .onAppear {
//            guard let data = UserDefaults.standard.data(forKey: "customUser#07"), let userObject = try? JSONDecoder().decode(CustomUser.self, from: data) else { return }
//            customUser = userObject
        }
    }
}

struct ContentView07_Previews: PreviewProvider {
    static var previews: some View {
        ContentView07()
    }
}
