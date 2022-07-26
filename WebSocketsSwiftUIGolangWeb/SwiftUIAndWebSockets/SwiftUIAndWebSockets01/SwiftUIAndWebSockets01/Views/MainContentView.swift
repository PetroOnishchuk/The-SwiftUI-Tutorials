//
//  MainContentView.swift
//  SwiftUIAndWebSockets01
//
//  Created by Petro Onishchuk on 7/25/22.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    PiesocketView()
                } label: {
                    Text("PiesocketView")
                }
                NavigationLink {
                    GOWebSocketView()
                } label: {
                 Text("GOWebSocketView")
                }
            }.navigationTitle("SwiftUI & WebSockets")
                .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
