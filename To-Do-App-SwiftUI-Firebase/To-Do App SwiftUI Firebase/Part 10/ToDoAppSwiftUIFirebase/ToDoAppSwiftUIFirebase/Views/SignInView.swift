//
//  SignInView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 12/24/22.
//

import SwiftUI
import FirebaseRemoteConfig
import FirebaseRemoteConfigSwift

struct SignInView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel 
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirmation = "" 
    var body: some View {
        List {
            Section {
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            } footer: {
                Text(myAppVM.checkEmailFields(email: email))
                    .foregroundColor(.red)
            }
            Section {
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                SecureField("Repeat password", text: $passwordConfirmation)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            } footer: {
                Text("\(myAppVM.checkPasswordFields(firstField: password, secondField: passwordConfirmation))")
                    .foregroundColor(.red)
            }
            Section {
                Button {
                    myAppVM.signIn(email: email, password: password)
                } label: {
                    Text("Sign In")
                }
                .disabled(!myAppVM.checkSignInFields(email: email, password: password, passwordConfirmation: passwordConfirmation))
                Button(role: .destructive) {
                    email = ""
                    password = ""
                } label: {
                    Text("Cancel")
                }
                
            } footer: {
                Text(myAppVM.checkSignInFields(email: email, password: password, passwordConfirmation: passwordConfirmation) ? "" : "Fill all fields")
            }
        }.navigationTitle("Sign In")
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
