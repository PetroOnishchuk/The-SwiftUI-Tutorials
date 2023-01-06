//
//  MyAppViewModel.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 12/23/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class MyAppViewModel: ObservableObject {
    @Published var userSignedIn: Bool = false
    @Published var path = NavigationPath()
    let auth = Auth.auth()
    @Published var isPresentAlert = false
    @Published var customAlertInfo = CustomAlertInfo(title: "", description: "")
    // PART #3
    @Published var mainUser = User(id: "", firstName: "", lastName: "", email: "")
    let db = Firestore.firestore()
    
    // MARK: Check isUserSignIn
    func isUserSignedIn() {
        let result = auth.currentUser != nil
        
        if result {
            takeCurrentUserData()
        }
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
    func signUp(firstName: String, lastName: String, email: String, password: String) {
        
        guard checkEmailAndPassword(email: email, password: password) == true else {
            print("Error while check an email and password")
            return
        }
        auth.createUser(withEmail: email, password: password) { [weak self]
            result, error in
            
            guard error == nil else {
                self?.showAlertWith(title: "Error with Sing Up", description: "Error: \(String(describing: error))")
                print("Error with SignUp \(String(describing: error))")
                return
            }
            
            guard let mainResult = result else {
                self?.showAlertWith(title: "Result is Nil", description: "The result with users data is Nil")
                return
            }
            
            let userUID = mainResult.user.uid
            
            guard let userEmail = result?.user.email else {
                print("Don't take 'result?.user.email' Error")
                self?.showAlertWith(title: "Error with 'result.user", description: "Error: 'result?.user.email == nil' ")
                return
            }
            print("SignUp with email: \(userEmail)\n")
            
            // MARK: Add user to Firestore
            self?.db.collection("users").document(userUID).setData(["firstName": firstName, "lastName": lastName, "email": userEmail], merge: true) { error in
                guard error == nil else {
                    self?.showAlertWith(title: "Error set users data to the Firestore", description: "Error: \(String(describing: error))")
                    return
                }
            }
            
            self?.isUserSignedIn()
            self?.backToRootScreen()
        }
    }
    
    //MARK: SignIn with email
    //Using  when you already have an account
    
    func signIn(email: String, password: String) {
        
        guard checkEmailAndPassword(email: email, password: password) == true else {
            print("Error while check email and password")
            return
        }
        
        auth.signIn(withEmail: email, password: password) { [weak self]
            result, error in
            
            guard error == nil else {
                print("Error with SignIn with email: \(String(describing: error))")
                self?.showAlertWith(title: "Error with Sign In", description: "Error: \(String(describing: error))")
                return
            }
            
            guard let userEmail = result?.user.email else {
                print("Don't take 'result?.user.email' error")
                self?.showAlertWith(title: "Error with result.user", description: "Error: 'result?.user.email == nil'")
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
    
    //MARK: Show Alert
    func showAlertWith(title: String, description: String) {
        DispatchQueue.main.async {
            [weak self] in
            self?.customAlertInfo.title = title
            self?.customAlertInfo.description = description
            self?.isPresentAlert = true
        }
    }
    
    //MARK: Check Email and Password
    func checkEmailAndPassword(email: String, password: String) -> Bool {
        
        let isValidEmail = email.isValidEmail
        //V 1.0
        let isValidPassword = password.count >= 6
        
        // V 2.0
        //let isValidPassword = password.isValidPassword
        
        switch (isValidEmail, isValidPassword) {
        case (true, true):
            return true
        case (false, false):
            showAlertWith(title: "Email & Password are invalid", description: "Email is invalid & Password < 6 characters")
            return false
        case (false, _):
            showAlertWith(title: "Email is invalid", description: "Incorrect Email format")
            return false
        case (_, false):
            showAlertWith(title: "Password is Invalid", description: "You password < 6 characters. Make password more longer.")
            return false
        }
        
    }
    
    // MARK: Take a user's data from the database.
    func takeCurrentUserData() {
        let currentUserUID = auth.currentUser?.uid ?? ""
        let currentUserEmail = auth.currentUser?.email ?? ""
        
        let docRef = db.collection("users").document(currentUserUID)
        
        docRef.getDocument {[weak self] snapshot, error in
            
            guard error == nil else {
                self?.showAlertWith(title: "Take Document Info Error", description: "Error \(String(describing: error))")
                return
            }
            
            guard let userData = snapshot else {
                self?.showAlertWith(title: "Snapshot is Nil", description: "Snapshot with user info is Nil")
                return
            }
            
            let firstName = userData["firstName"] as? String ?? ""
            let lastName = userData["lastName"] as? String ?? ""
            
            let newUser = User(id: currentUserUID, firstName: firstName, lastName: lastName, email: currentUserEmail)
            DispatchQueue.main.async {
                self?.mainUser = newUser
            }
        }
    }
}
