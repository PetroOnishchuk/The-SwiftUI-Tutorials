//
//  ContentView031.swift
//  ContentView031
//
//  Created by Petro Onishchuk on 7/19/21.
//

import SwiftUI

struct ContentView031: View {
    
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
        }
    }
}

struct ContentView031_Previews: PreviewProvider {
    static var previews: some View {
        ContentView031()
    }
}
