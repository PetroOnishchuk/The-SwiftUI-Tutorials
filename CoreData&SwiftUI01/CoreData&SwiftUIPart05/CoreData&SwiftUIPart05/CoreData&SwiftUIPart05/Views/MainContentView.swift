//
//  MainContentView.swift
//  CoreData&SwiftUIPart05
//
//  Created by Petro Onishchuk  
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        NavigationView {
            List {
                ListBooksView()
            }.toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                       NewBookView()
                    }label: {
                        Label("Label", systemImage: "plus")
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Text("List pf Books"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
