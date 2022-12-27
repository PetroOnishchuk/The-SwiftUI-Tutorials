//
//  FontViewModifier.swift
//  SwiftUIandFirebaseAndPushNotifications01
//
//  Created by Petro Onishchuk on 8/26/22.
//

import Foundation
import SwiftUI

struct FontSize: ViewModifier {
    var size: CGFloat
    
    func body(content: Content) -> some View {
    content
            .font(Font.system(size: size))
    }
    
}

extension View {
    func customFontSize(with size: CGFloat) -> some View {
        modifier(FontSize(size: size))
    }
}
