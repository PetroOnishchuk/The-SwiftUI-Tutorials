//
//  MainLoginView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 12/23/22.
//

import SwiftUI

struct MainLoginView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    
    var body: some View {
        List {
            NavigationLink("Sign In / Already registered", value: "signIn")
            NavigationLink("Sign Up / Create a new user", value: "signUp")
        }
        .navigationTitle("SignIn / SignUp")
    }
}

struct MainLoginView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoginView()
    }
}
