//
//  ListWithListContainerView.swift
//  HierarchicalList01
//
//  Created by Petro Onishchuk on 6/2/21.
//

import SwiftUI

struct ListWithListContainerView: View {
    
    var allEmoji: [Emoji]
    
    
    var body: some View {
        List(allEmoji, children: \.emojiList) { emoji in
            HStack {
                Text(emoji.name.capitalized)
                Spacer()
                Text(emoji.symbol)
            }
        }
        .navigationTitle(Text("List with List Container"))
    }
}

//struct ListWithListContainerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListWithListContainerView()
//    }
//}
