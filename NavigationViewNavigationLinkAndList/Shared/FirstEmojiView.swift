//
//  ContentView.swift
//  Shared
//
//  Created by Petro Onishchuk on 2/25/21.
//

import SwiftUI

struct FirstEmojiView: View {
    
    let allEmojiCategories = EmojiCategory.allCategories
    
    var body: some View {
        
        NavigationView {
            List(allEmojiCategories, id: \.id){ emojiCategory in
                NavigationLink(
                    destination: SecondEmojiView(emojiCategory: emojiCategory),
                    label: {
                        HStack {
                            Text(emojiCategory.name.capitalized)
                            Spacer()
                            Text(emojiCategory.symbol)
                        }
                    })
            }
            .navigationTitle(Text("Emoji Categories"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FirstEmojiView()
            .preferredColorScheme(.dark)
    }
}
