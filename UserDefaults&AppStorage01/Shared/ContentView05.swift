//
//  ContentView05.swift
//  ContentView05
//
//  Created by Petro Onishchuk on 7/19/21.
//

import SwiftUI

struct ContentView05: View {
    
    @State var user = BasicUser(firstName: "", secondName: "")
    
    var body: some View {
        List {
            Section(header: Text(SectionPlaceholder.userFirstName.rawValue)) {
                Text(user.firstName)
            }
            Section(header: Text(SectionPlaceholder.userSecondName.rawValue)) {
                Text(user.secondName)
            }
            Section(header: Text(SectionPlaceholder.firstUserField.rawValue)) {
                TextField(SectionPlaceholder.enterFirstName.rawValue, text: $user.firstName)
            }
            Section(header: Text(SectionPlaceholder.secondUserField.rawValue)) {
                TextField(SectionPlaceholder.enterSecondName.rawValue, text: $user.secondName)
            }
            Section(header: Text(SectionPlaceholder.buttonSection.rawValue)) {
                Button(SectionPlaceholder.nameOfButton.rawValue) {
                    guard let encodeData = try? JSONEncoder().encode(user) else { return }
                    UserDefaults.standard.set(encodeData, forKey: "userObject#05")
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(UserDefaultsSection.stateAndCustomObject.rawValue)
        .onAppear {
            guard let data = UserDefaults.standard.data(forKey: "userObject#05"), let userObject = try? JSONDecoder().decode(BasicUser.self, from: data) else { return }
            user = userObject
        }
    }
}

struct ContentView05_Previews: PreviewProvider {
    static var previews: some View {
        ContentView05()
    }
}
