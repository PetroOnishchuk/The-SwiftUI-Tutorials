//
//  Emoji.swift
//  HierarchicalList01 (iOS)
//
//  Created by Petro Onishchuk on 6/1/21.
//

import Foundation

struct Emoji: Identifiable {
    var id = UUID()
    var name: String
    var symbol: String
    var emojiList: [Emoji]?
    
    static let allEmoji = [
        Emoji(name: "Smileys & People", symbol: "😀😷👨‍💻",
              emojiList: [Emoji(name: "grinning face", symbol: "😀"),
                          Emoji(name: "ghost", symbol: "👻"),
                          Emoji(name: "cowboy face", symbol: "🤠"),
                          Emoji(name: "clown face", symbol: "🤡"),
                          Emoji(name: "tooth", symbol: "🦷"),
                          Emoji(name:  "policeman", symbol: "👮‍♂️"),
                          Emoji(name:  "woman scientist", symbol: "👩‍🔬"),
                          Emoji(name:  "gloves", symbol: "🧤")
              ]),
        Emoji(name: "Animals & Nature", symbol: "🐶🐱🍀",
              emojiList: [Emoji(name: "dog face", symbol: "🐶"),
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
                          Emoji(name: "Second Path of Animals & Nature ", symbol: "🦆🦅🦖",
                                emojiList:[
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
                                ]),
                          
                          
              ]),
        Emoji(name: "Food & Drink", symbol: "🍏🍔🥛",
              emojiList: [Emoji(name: "green apple", symbol: "🍏"),
                          Emoji(name: "pear", symbol: "🍐"),
                          Emoji(name: "lemon", symbol: "🍋"),
                          Emoji(name: "banana", symbol: "🍌"),
                          Emoji(name: "kiwi", symbol: "🥝"),
                          Emoji(name: "hamburger", symbol: "🍔"),
                          Emoji(name: "taco", symbol: "🌮"),
                          Emoji(name: "glass of milk", symbol: "🥛"),
              ]),
        Emoji(name: "Activity", symbol: "⚽️🏀🏋️",
              emojiList: [ Emoji(name: "soccer ball", symbol: "⚽️"),
                           Emoji(name: "basketball", symbol: "🏀"),
                           Emoji(name: "rugby football", symbol: "🏉"),
                           Emoji(name: "diving mask", symbol: "🤿"),
                           Emoji(name: "boxing glove", symbol: "🥊"),
                           Emoji(name: "weightlifter", symbol: "🏋️"),
                           Emoji(name: "golfer", symbol: "🏌️"),
                           Emoji(name: "swimmer", symbol: "🏊"),
                           Emoji(name: "headphones", symbol: "🎧"),
              ]),
        Emoji(name: "Travel & Places", symbol: "🚗🚲🚀",
              emojiList: [Emoji(name: "car", symbol: "🚗"),
                          Emoji(name: "ambulance", symbol: "🚑"),
                          Emoji(name: "bicycle", symbol: "🚲"),
                          Emoji(name: "motorcycle", symbol: "🏍"),
                          Emoji(name: "high-speed train", symbol: "🚄"),
                          Emoji(name: "airplane", symbol: "✈️"),
                          Emoji(name: "rocket", symbol: "🚀"),
                          Emoji(name: "passenger ship", symbol: "🛳"),
                          Emoji(name: "Statue of Liberty", symbol: "🗽")
              ]),
        Emoji(name: "Objects", symbol: "📱💻🧲",
              emojiList: [Emoji(name: "watch", symbol: "⌚️"),
                          Emoji(name: "mobile phone", symbol: "📱"),
                          Emoji(name: "laptop", symbol: "💻"),
                          Emoji(name: "joystick", symbol: "🕹"),
                          Emoji(name: "studio microphone", symbol: "🎙"),
                          Emoji(name: "stopwatch", symbol: "⏱"),
                          Emoji(name: "credit card", symbol: "💳"),
                          Emoji(name: "pill", symbol: "💊"),
                          Emoji(name: "bed", symbol: "🛏"),
              ]),
        Emoji(name: "Symbols", symbol: "💯✅🎦",
              emojiList: [Emoji(name: "red heart", symbol: "❤️"),
                          Emoji(name: "radioactive", symbol: "☢️"),
                          Emoji(name: "hundred point symbol", symbol: "💯"),
                          Emoji(name: "check mark symbol", symbol: "✅"),
                          Emoji(name: "recycling symbol", symbol: "♻️"),
                          Emoji(name: "cellular signal bars", symbol: "📶"),
                          Emoji(name: "musical notes", symbol: "🎶"),
                          Emoji(name: "green circle", symbol: "🟢"),
                          Emoji(name: "one o'clock", symbol: "🕐"),
              ]),
        Emoji(name: "Flags", symbol: "🇺🇸🇦🇶🇲🇽",
              emojiList: [Emoji(name: "flag of the United States", symbol: "🇺🇸"),
                          Emoji(name: "flag of Mexico", symbol: "🇲🇽"),
                          Emoji(name: "pirate flag", symbol: "🏴‍☠️"),
                          Emoji(name: "flag of Antarctica", symbol: "🇦🇶"),
                          Emoji(name: "flag of American Samoa", symbol: "🇦🇸"),
                          Emoji(name: "flag of Australia", symbol: "🇦🇺"),
                          Emoji(name: "flag of Brazil", symbol: "🇧🇷"),
                          Emoji(name: "flag of Canada", symbol: "🇨🇦"),
                          Emoji(name: "flag of Ukraine", symbol: "🇺🇦"),
              ])
    ]
}



