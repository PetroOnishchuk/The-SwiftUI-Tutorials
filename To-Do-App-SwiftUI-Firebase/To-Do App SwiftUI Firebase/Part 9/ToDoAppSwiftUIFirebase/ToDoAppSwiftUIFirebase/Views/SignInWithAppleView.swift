//
//  SignInWithAppleView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 1/26/23.
//

import SwiftUI
import AuthenticationServices
import Firebase


struct SignInWithAppleView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    @State var currentNonce: String?
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        SignInWithAppleButton { request in
            let nonce = myAppVM.randomNonceString()
            currentNonce = nonce
            request.requestedScopes = [.fullName, .email]
            request.nonce = myAppVM.sha256(nonce)
            
        } onCompletion: { result in
            switch result {
            case .success(let authResult):
                switch authResult.credential {
                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                    guard let nonce = currentNonce else {
                        fatalError("Invalid state: A login callback was receive, but no login request was sent.")
                    }
                    guard let appleIDToken = appleIDCredential.identityToken else {
                        print("Unable to fetch identity token")
                        return
                    }
                    guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                        return
                    }
                    let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
                    
                    Auth.auth().signIn(with: credential) {
                        authResult, error in
                        guard error == nil else {
                            myAppVM.showAlertWith(title: "Error with SignIN with Apple", description: "Error: \(String(describing: error))")
                            return
                        }
                        
                        guard authResult != nil else {
                            myAppVM.showAlertWith(title: "Auth Result Is Nil", description: "Auth Result is nil after  you try to SignIn with Apple")
                            return
                        }
                        myAppVM.isUserSignedIn()
                    }
                default:
                    break
                    
                }
            case .failure(_):
                break
            }
        }.signInWithAppleButtonStyle(buttonStyle)
            .id(colorScheme)
            .frame(maxWidth: 175, alignment: .center)
            .frame(height: 45)

    }
    
    private var buttonStyle: SignInWithAppleButton.Style {
        switch colorScheme {
        case .light: return .black
        case .dark: return .white
        @unknown default: return .black
        }
    }
}

struct SignInWithAppleView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleView()
    }
}
