//
//  ContentView02.swift
//  ContentView02
//
//  Created by Petro Onishchuk on 7/19/21.
//

import SwiftUI

struct ContentView02: View {
    
    @AppStorage("firstName02") var firstName = ""
    @AppStorage("secondName02") var secondName = ""
    
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
        }
        .navigationTitle(UserDefaultsSection.appStorageSimple.rawValue)
    }
}

struct ContentView02_Previews: PreviewProvider {
    static var previews: some View {
        ContentView02()
    }
}
