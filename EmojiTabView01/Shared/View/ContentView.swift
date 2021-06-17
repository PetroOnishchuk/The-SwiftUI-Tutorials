//
//  ContentView.swift
//  Shared
//
//  Created by Petro Onishchuk on 6/16/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var emojiVM = EmojiViewModel()
    
    var body: some View {
        NavigationView {
            TabView(selection: $emojiVM.selection) {
                EmojiListView(category: emojiVM.allCategories[Category.people.rawValue])
                    .tabItem {
                        Label("People", systemImage: "face.smiling.fill")
                    }
                    .tag(0)
                EmojiListView(category: emojiVM.allCategories[Category.nature.rawValue])
                    .tabItem {
                        Label("Nature", systemImage: "leaf.fill")
                    }
                    .tag(1)
                EmojiListView(category: emojiVM.allCategories[Category.activity.rawValue])
                    .tabItem {
                        Label("Activity", systemImage: "figure.walk")
                    }
                    .tag(2)
                EmojiListView(category: emojiVM.allCategories[Category.foodAndDrink.rawValue])
                    .tabItem {
                        Label("Food & Drink", systemImage: "fork.knife.circle.fill")
                    }
                    .tag(3)
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        emojiVM.moveBackward()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Next") {
                        emojiVM.moveForward()
                    }
                }
            })
            .navigationTitle(Text("Emoji"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
