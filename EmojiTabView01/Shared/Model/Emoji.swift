//
//  Emoji.swift
//  EmojiTabView01 (iOS)
//
//  Created by Petro Onishchuk on 6/16/21.
//

import SwiftUI

enum Category: Int {
    case people = 0
    case nature = 1
    case activity = 2
    case foodAndDrink = 3
}

// For create an Emoji object
struct Emoji {
    var id : UUID
    var name : String
    var symbol : String
    
    init(name: String, symbol: String ) {
        self.id = UUID()
        self.name = name
        self.symbol = symbol
    }
}


// For create an EmojiCategory object
class EmojiCategory: ObservableObject {
    var id: UUID
    var name: String
    var symbol: String
    var emojiList: [Emoji]
    
    init(name: String, symbols: String, emojisList: [Emoji] ) {
        self.id = UUID()
        self.name = name
        self.symbol = symbols
        self.emojiList = emojisList
    }
    
    static let allCategories =
    [EmojiCategory(name: "People", symbols: "👨‍👩‍👦‍👦", emojisList: [
        Emoji(name: "baby", symbol: "👶"),
        Emoji(name: "man", symbol: "👨"),
        Emoji(name: "woman with curly hair", symbol: "👩‍🦱"),
        Emoji(name: "policewoman", symbol: "👮‍♀️"),
        Emoji(name: "policeman", symbol: "👮‍♂️"),
        Emoji(name: "construction worker", symbol: "👷"),
        Emoji(name: "detective", symbol: "🕵️")
    ]),EmojiCategory(name: "Nature", symbols: "🐶🐰🐱", emojisList: [
        Emoji(name: "dog face", symbol: "🐶"),
        Emoji(name: "cat face", symbol: "🐱"),
        Emoji(name: "mouse face", symbol: "🐭"),
        Emoji(name: "hamster face", symbol: "🐹"),
        Emoji(name: "rabbit face", symbol: "🐰"),
        Emoji(name: "fox face", symbol: "🦊"),
        Emoji(name: "bear face", symbol: "🐻"),
        Emoji(name: "panda face", symbol: "🐼"),
        Emoji(name: "polar bear", symbol: "🐻‍❄️"),
        Emoji(name: "koala face", symbol: "🐨"),
        Emoji(name: "tiger face", symbol: "🐯"),
        Emoji(name: "duck", symbol: "🦆"),
        Emoji(name: "eagle", symbol: "🦅"),
        Emoji(name: "bee", symbol: "🐝"),
        Emoji(name: "snake", symbol: "🐍"),
        Emoji(name: "chicken", symbol: "🐔"),
        Emoji(name: "T-Rex", symbol: "🦖"),
        Emoji(name: "dinosaur", symbol: "🦕"),
        Emoji(name: "fish", symbol: "🐟"),
        Emoji(name: "elephant", symbol: "🐘"),
        Emoji(name: "cat", symbol: "🐈"),
        Emoji(name: "rabbit", symbol: "🐇"),
        Emoji(name: "dragon", symbol: "🐉"),
        Emoji(name: "four leaf clover", symbol: "🍀")
    ]),EmojiCategory(name: "Activity", symbols: "⛷🏂🏋️", emojisList: [
        Emoji(name: "skier", symbol: "⛷"),
        Emoji(name: "snowboarder", symbol: "🏂"),
        Emoji(name: "parachute", symbol: "🪂"),
        Emoji(name: "weightlifter", symbol: "🏋️"),
        Emoji(name: "people wrestling", symbol: "🤼"),
        Emoji(name: "person doing a cartwheel", symbol: "🤸"),
        Emoji(name: "person rowing boat", symbol: "🚣"),
        Emoji(name: "woman cyclist", symbol: "🚴‍♀️"),
        Emoji(name: "woman playing water polo", symbol: "🤽‍♀️"),
        Emoji(name: "soccer ball", symbol: "⚽️"),
        Emoji(name: "basketball", symbol: "🏀"),
        Emoji(name: "rugby football", symbol: "🏉"),
        Emoji(name: "diving mask", symbol: "🤿"),
        Emoji(name: "boxing glove", symbol: "🥊"),
        Emoji(name: "weightlifter", symbol: "🏋️"),
        Emoji(name: "golfer", symbol: "🏌️"),
        Emoji(name: "swimmer", symbol: "🏊"),
        Emoji(name: "headphones", symbol: "🎧")
    ]),EmojiCategory(name: "Food & Drink", symbols: "🍏🍔🥛",emojisList:[
        Emoji(name: "green apple", symbol: "🍏"),
        Emoji(name: "pear", symbol: "🍐"),
        Emoji(name: "lemon", symbol: "🍋"),
        Emoji(name: "banana", symbol: "🍌"),
        Emoji(name: "kiwi", symbol: "🥝"),
        Emoji(name: "hamburger", symbol: "🍔"),
        Emoji(name: "taco", symbol: "🌮"),
        Emoji(name: "glass of milk", symbol: "🥛"),
    ]),
    ]
}






