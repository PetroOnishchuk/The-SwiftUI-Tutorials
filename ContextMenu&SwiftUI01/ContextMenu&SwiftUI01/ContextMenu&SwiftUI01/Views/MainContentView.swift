//
//  MainContentView.swift
//  ContextMenu&SwiftUI01
//
//  Created by Petro Onishchuk on 12/24/21.
//

import SwiftUI 

struct MainContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Single Context Menu") {
                    SingleContextMenuView()
                }
                NavigationLink("Multiply Context Menu") {
                    MultipleContextMenuView()
                }
                
                
            }.navigationTitle(Text("Context Menu & SwiftUI"))
                .navigationBarTitleDisplayMode(.inline) 
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
