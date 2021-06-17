//
//  EmojiListView.swift
//  EmojiTabView01
//
//  Created by Petro Onishchuk on 6/16/21.
//

import SwiftUI

struct EmojiListView: View {
    
    var category: EmojiCategory
    
    var body: some View {
        List {
            ForEach(category.emojiList, id:\.id){ emoji in
                HStack {
                    Text(emoji.name.capitalizingFirstLetter())
                    Spacer()
                    Text(emoji.symbol)
                }
            }
        }
        .navigationTitle("Emoji category")
        .listStyle(.plain)
        
    }
}

struct EmojiListView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiListView(category: EmojiCategory.allCategories[0])
    }
}
