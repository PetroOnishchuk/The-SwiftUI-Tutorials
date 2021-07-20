//
//  ContentView01.swift
//  ContentView01
//
//  Created by Petro Onishchuk on 7/19/21.
//

import SwiftUI

struct ContentView01: View {
    
    @State var firstName = ""
    @State var secondName = ""
    
    var body: some View {
        List {
            Section(header: Text(SectionPlaceholder.userFirstName.rawValue)) {
                Text(firstName)
            }
            Section(header: Text(SectionPlaceholder.userSecondName.rawValue)) {
                Text(secondName)
            }
            Section(header: Text(SectionPlaceholder.firstUserField.rawValue)) {
                TextField(SectionPlaceholder.enterFirstName.rawValue, text: $firstName)
            }
            Section(header: Text(SectionPlaceholder.secondUserField.rawValue)) {
                TextField(SectionPlaceholder.enterSecondName.rawValue, text: $secondName)
            }
            Section(header: Text(SectionPlaceholder.buttonSection.rawValue)) {
                Button(SectionPlaceholder.nameOfButton.rawValue) {
                    UserDefaults.standard.set(firstName, forKey: "firstName#01")
                    UserDefaults.standard.set(secondName, forKey: "secondName#01")
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(UserDefaultsSection.state.rawValue)
        .onAppear{
            guard let firstName = UserDefaults.standard.object(forKey: "firstName#01") as? String else { return }
            self.firstName = firstName
            
            guard let secondName = UserDefaults.standard.object(forKey: "secondName#01") as? String else { return }
            self.secondName = secondName
        }
    }
}

struct ContentView01_Previews: PreviewProvider {
    static var previews: some View {
        ContentView01()
    }
}
