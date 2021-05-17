//
//  ContentView.swift
//  Shared
//
//  Created by Petro Onishchuk on 5/15/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var user = User(name: "******", job: "******", id: nil, dateCreated: nil)
    
    var body: some View {
        NavigationView {
            VStack {
                List() {
                    Section(header: Text("Our Data")) {
                        Text("Name: \(user.name)")
                        Text("Job: \(user.job)")
                        Text("ID: \(user.modifiedId)")
                        Text("Date created: \(user.modifiedDateCreated)")
                    }
                }
                .listStyle(GroupedListStyle())
                Button {
                    // Make POST Request
                    
                    UserURLSession.shared.userPostRequest { newUser in
                        DispatchQueue.main.async {
                            user = newUser
                        }
                    }
                    
                } label: {
                    Text("POST Request")
                }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.green)
                .cornerRadius(8)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("POST Request"))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
