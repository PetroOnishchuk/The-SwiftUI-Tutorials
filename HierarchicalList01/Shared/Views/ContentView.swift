//
//  ContentView.swift
//  Shared
//
//  Created by Petro Onishchuk on 6/1/21.
//

import SwiftUI

struct ContentView: View {
    
    let allEmoji = Emoji.allEmoji
    @State var isShowCategories = false
    
    var body: some View {
        NavigationView {
            VStack {
                DisclosureGroup("Show categories", isExpanded: $isShowCategories) {
                    NavigationLink("List with List Container", destination: ListWithListContainerView(allEmoji: allEmoji))
                        .padding()
                    NavigationLink("List with OutlineGroup", destination: ListWithOutlineGroupView(allEmoji: allEmoji))
                        .padding()
                    Button("Hide categories") {
                        isShowCategories.toggle()
                    }
                    .foregroundColor(Color.red)
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Select Emoji List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
