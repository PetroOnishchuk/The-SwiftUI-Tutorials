//
//  ThirdEmojiView.swift
//  NavigationViewNavigationLinkAndList
//
//  Created by Petro Onishchuk on 2/26/21.
//

import SwiftUI

struct ThirdEmojiView: View {
    
    let emoji: Emoji
    
    var body: some View {
        VStack {
            Text(emoji.name.capitalized)
                .padding(.bottom, 40)
                .font(.title)
            Text(emoji.symbol)
                .font(.system(size: 180))
                .padding(.bottom, 220)
        }
        .navigationTitle(Text("Selected Emoji"))
    }
}

struct ThirdEmojiView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdEmojiView(emoji: Emoji(name: "ghost", symbol: "👻"))
    }
}
