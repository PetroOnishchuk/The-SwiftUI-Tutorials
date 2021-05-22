//
//  EmojiAlertView.swift
//  Shared
//
//  Created by Petro Onishchuk on 5/22/21.
//

import SwiftUI

struct EmojiAlertView: View {
    
    @StateObject var emojiViewModel = EmojiViewModel()
    
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(emojiViewModel.allEmoji, id: \.id){ emoji in
                    Button(action: {
                        emojiViewModel.alertForEmoji = AlertForEmoji(name: emoji.name, symbol: emoji.symbol)
                        emojiViewModel.selectedEmoji = emoji
                    }, label: {
                        HStack {
                            Text(emoji.name.capitalized)
                            Spacer()
                            Text(emoji.symbol)
                        }
                    })
                }
            }
            .alert(item: $emojiViewModel.alertForEmoji, content: { alert in
                emojiViewModel.setAlert(with: alert.name, symbol: alert.symbol)
            })
            .navigationTitle(Text("Emoji Alert"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiAlertView()
    }
}
