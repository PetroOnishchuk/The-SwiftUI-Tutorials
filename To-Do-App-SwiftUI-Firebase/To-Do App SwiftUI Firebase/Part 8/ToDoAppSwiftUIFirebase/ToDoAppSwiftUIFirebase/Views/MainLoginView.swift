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
        ZStack {
            BackgroundGradientView()
            VStack {
                NavigationLink("Sign In / Already registered", value: "signIn")
                    .signInSignUpButtonStyle()
                NavigationLink("Sign Up / Create a new user", value: "signUp")
                    .signInSignUpButtonStyle()
                
                SignInWithAppleView()
                Spacer()
            }
            .padding(.top, 20)
            .navigationTitle("SignIn / SignUp")
        }
    }
}

struct MainLoginView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoginView()
    }
}
