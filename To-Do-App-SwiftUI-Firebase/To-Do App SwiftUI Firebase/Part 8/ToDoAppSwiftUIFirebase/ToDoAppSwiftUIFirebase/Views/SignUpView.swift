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
    
    var body: some View {
        List {
            Section {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            } header: {
                Text("Text Field Section")
            }
            
            Section {
                Button {
                    myAppVM.signUp(firstName: firstName, lastName: lastName, email: email, password: password)
                } label: {
                    Text("Sign Up")
                }
                .disabled(firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty)
                Button(role: .destructive) {
                    firstName = ""
                    lastName = ""
                    email = ""
                    password = ""
                } label: {
                    Text("Cancel")
                }
                
            } header: {
                Text("Button Section")
            }
        }.navigationTitle("Sign In View Screen")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
