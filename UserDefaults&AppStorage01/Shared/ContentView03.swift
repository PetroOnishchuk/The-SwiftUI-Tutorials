//
//  ContentView03.swift
//  ContentView03
//
//  Created by Petro Onishchuk on 7/19/21.
//

import SwiftUI

struct ContentView03: View {
    @SceneStorage("firstName03") var firstName = ""
    @SceneStorage("secondName03") var secondName = ""
    
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
            Section(header: Text("Link to the second View")) {
                NavigationLink("Second View") {
                    ContentView031()
                }
            }
        }
      
    }
}

struct ContentView03_Previews: PreviewProvider {
    static var previews: some View {
        ContentView03()
    }
}
