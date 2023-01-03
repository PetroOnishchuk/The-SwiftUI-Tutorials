//
//  MyAppViewModel.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 12/23/22.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseCore

class MyAppViewModel: ObservableObject {
    @Published var userSignedIn: Bool = false
    @Published var path = NavigationPath()
    let auth = Auth.auth()
    
    // MARK: Check isUserSignIn
    func isUserSignedIn() {
        let result = auth.currentUser != nil
        DispatchQueue.main.async {
            [weak self] in
            self?.userSignedIn = result
        }
    }
    
    //MARK: Back to the Root Screen
    func backToRootScreen() {
        DispatchQueue.main.async {
            [weak self] in
            self?.path = .init()
        }
    }
    
    //MARK: SignUp
    //If You want to create a new account
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self]
            result, error in
            
            guard error == nil else {
                print("Error with SignUp \(String(describing: error))")
                return
            }
            
            guard let userEmail = result?.user.email else {
                print("Don't take 'result?.user.email' Error")
                return
            }
            print("SignUp with email: \(userEmail)\n")
            
            self?.isUserSignedIn()
            self?.backToRootScreen()
        }
    }
    
    //MARK: SignIn with email
    //Using  when you already have an account
    
    func signIn(email: String, password: String) {
        
        auth.signIn(withEmail: email, password: password) { [weak self]
            result, error in
            
            guard error == nil else {
                print("Error with SignIn with email: \(String(describing: error))")
                return
            }
            
            guard let userEmail = result?.user.email else {
                print("Don't take 'result?.user.email' error")
                return
            }
            print("SignIn with email: \(userEmail)\n")
            
            self?.isUserSignedIn()
            self?.backToRootScreen()
        }
    }
    
    //MARK: SignOut
    func signOut() {
        do {
            try auth.signOut()
        } catch {
            print("error with SignOut: \(error)")
        }
        
        isUserSignedIn()
        backToRootScreen()
    }
}
