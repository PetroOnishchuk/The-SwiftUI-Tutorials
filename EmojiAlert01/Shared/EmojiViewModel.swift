//
//  EmojiViewModel.swift
//  EmojiAlert01
//
//  Created by Petro Onishchuk on 5/22/21.
//

import SwiftUI


class EmojiViewModel: ObservableObject {
    
    @Published var allEmoji = Emoji.allEmoji
    @Published var alertForEmoji: AlertForEmoji?
    @Published var selectedEmoji: Emoji?
    
    func setAlert(with name: String, symbol: String) -> Alert {
        Alert(title: Text("Emoji: \(name.capitalized)"), message: Text(symbol), primaryButton: .default(Text("OK")), secondaryButton: .destructive(Text("Delete"), action: {[self] in
            deleteEmoji()
        }))
    }
    
    
    
    func deleteEmoji() {
        if let index = allEmoji.firstIndex(where: { emoji in
            emoji.id == selectedEmoji?.id
        }) {
            DispatchQueue.main.async {
                self.allEmoji.remove(at: index)
            }
            
        } else {
            print("Can't delete Emoji")
        }
    }
    
    
}
