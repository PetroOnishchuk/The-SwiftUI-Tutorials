//
//  SignUpView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 12/24/22.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirmation = ""
    var body: some View {
        List {
            Section {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName) 
            } footer: {
                Text(myAppVM.checkUserFields(firstName: firstName, lastName: lastName))
                    .foregroundColor(.red)
            }
            
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
                    myAppVM.signUp(firstName: firstName, lastName: lastName, email: email, password: password)
                } label: {
                    Text("Sign Up")
                }
                .disabled(!myAppVM.checkSignUPFields(firstName: firstName, lastName: lastName, email: email, password: password, passwordConfirmation: passwordConfirmation))
                Button(role: .destructive) {
                    firstName = ""
                    lastName = ""
                    email = ""
                    password = ""
                    passwordConfirmation = ""
                } label: {
                    Text("Cancel")
                }
                
            } footer: {
                Text(myAppVM.checkSignUPFields(firstName: firstName, lastName: lastName, email: email, password: password, passwordConfirmation: passwordConfirmation) ? "" : "Fill all fields")
                    .foregroundColor(.red)
            }
        }.navigationTitle("Sign Up")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
