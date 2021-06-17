//
//  EmojiViewModel.swift
//  EmojiTabView01
//
//  Created by Petro Onishchuk on 6/16/21.
//

import SwiftUI

class EmojiViewModel: ObservableObject {
    
    @Published var allCategories = EmojiCategory.allCategories
    @Published var selection = 0
    
    // some logic later
    
    
    func moveBackward() {
        switch selection {
        case 0:
            selection = Category.foodAndDrink.rawValue
        default:
            selection -= 1
        }
    }
    
    func moveForward() {
        switch selection {
        case 3:
            selection = Category.people.rawValue
        default :
            selection += 1
        }
    }
    
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
