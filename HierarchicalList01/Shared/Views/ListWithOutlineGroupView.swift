//
//  ListWithOutlineGroupView.swift
//  HierarchicalList01
//
//  Created by Petro Onishchuk on 6/2/21.
//

import SwiftUI

struct ListWithOutlineGroupView: View {
    
    var allEmoji: [Emoji]
    
    
    var body: some View {
        ScrollView {
            OutlineGroup(allEmoji, children: \.emojiList) { emoji in
                HStack {
                    Text(emoji.name.capitalized)
                        .padding()
                    Spacer()
                    Text(emoji.symbol)
                }
            }
            .navigationTitle(Text("List with OutlineGroup"))
        }
    }
}

//struct ListWithOutlineGroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListWithOutlineGroupView()
//    }
//}
