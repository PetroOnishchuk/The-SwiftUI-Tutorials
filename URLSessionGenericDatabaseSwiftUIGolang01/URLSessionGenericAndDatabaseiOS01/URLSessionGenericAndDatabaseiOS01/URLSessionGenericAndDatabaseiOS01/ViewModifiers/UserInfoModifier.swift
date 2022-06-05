//
//  UserInfoModifier.swift
//  URLSessionGenericAndDatabaseiOS01
//
//  Created by Petro Onishchuk on 6/2/22.
//

import SwiftUI

struct EmojiAvatar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 60))
            .frame(width: 60, height: 60)
    }
}

extension View {
    func emojiAvatarStyle() -> some View {
        modifier(EmojiAvatar())
    }
}
