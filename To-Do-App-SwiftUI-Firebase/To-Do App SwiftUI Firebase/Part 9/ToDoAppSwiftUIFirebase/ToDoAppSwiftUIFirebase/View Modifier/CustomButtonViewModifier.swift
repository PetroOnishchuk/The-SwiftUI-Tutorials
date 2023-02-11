//
//  CustomButtonViewModifier.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 1/26/23.
//

import Foundation
import SwiftUI

struct CustomButtonViewModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: 175, alignment: .center)
            .frame(height: 45)
            .background(colorScheme == ColorScheme.light ? Color.black : Color.white)
            .foregroundColor(colorScheme == ColorScheme.light ? Color.white : Color.black)
            .cornerRadius(7)
    }
}

extension View {
    func signInSignUpButtonStyle() -> some View {
        modifier(CustomButtonViewModifier())
    }
}

