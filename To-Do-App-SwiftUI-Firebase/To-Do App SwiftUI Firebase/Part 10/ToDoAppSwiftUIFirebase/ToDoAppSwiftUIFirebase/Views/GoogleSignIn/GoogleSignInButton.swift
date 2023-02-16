//
//  GoogleSignInButton.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 2/9/23.
//   

import SwiftUI
import GoogleSignIn

struct GoogleSignInButton: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    
    private var button = GIDSignInButton()
    
    func makeUIView(context: Context) -> some UIView {
        button.colorScheme = colorScheme == .dark ? .light : .dark
        return button
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        button.colorScheme = colorScheme == .dark ? .light : .dark
    }
    
}
 

 
