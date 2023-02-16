//
//  ExtensionSignInGoogleVM.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 2/13/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import CryptoKit
import GoogleSignIn
import GoogleSignInSwift

extension MyAppViewModel {
    // MARK: PART #9
    // SignIn with Google
    func googleSignIn() {
        
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn(){
                [unowned self] user, error in
                authenticateGoogleUser(for: user, with: error)
                
            }
        } else {
            
            
            guard let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowsScene.windows.first?.rootViewController else { return }
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] result, error in
                guard let user = result?.user else {
                    print("Don't have a user")
                    return
                }
                
                authenticateGoogleUser(for: user, with: error)
            }
            
            
        }
    }
    
    private func authenticateGoogleUser(for user: GIDGoogleUser?, with error: Error?) {
        guard  error == nil else {
            print("Error with authenticateGoogleUser \(String(describing: error))")
            showAlertWith(title: "Error: Google Notification", description: "Error: \(String(describing: error))")
            return
        }
        
        guard let idToken = user?.idToken else {
            return
        }
        guard let accessToken = user?.accessToken else {
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken:  accessToken.tokenString)
        
        Auth.auth().signIn(with: credential) {
            [weak self] (_, error) in
            guard error == nil else {
                self?.showAlertWith(title: "SignIn with Google Error", description: "Error: \(String(describing: error))")
                return
            }
            
            self?.isUserSignedIn()
            self?.backToRootScreen()
            
        }
    }
}
