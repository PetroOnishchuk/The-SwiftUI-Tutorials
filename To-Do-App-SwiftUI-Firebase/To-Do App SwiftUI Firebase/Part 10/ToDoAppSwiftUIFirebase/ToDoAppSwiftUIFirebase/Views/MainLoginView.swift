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
                Spacer()
                VStack(alignment: .leading, spacing: 5)  {
                    Text("Just Do It.")
                    Text("Don’t limit yourself.")
                    Text("Do one thing every day that scares you.")
                    Text("Impossible is just an opinion.")
                    Text("One day or day one. You decide.")
                    Text("Dreams don’t work unless you do.")
                    Text("Begin anywhere.")
                }.font(
                    .custom(
                        "AmericanTypewriter",
                        fixedSize: 24)
                    .weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
                .padding(.leading, 20)
                Spacer()
                HStack {
                    NavigationLink("Sign In", value: "signIn")
                        .signInSignUpButtonStyle()
                    
                    NavigationLink("Sign Up", value: "signUp")
                        .signInSignUpButtonStyle()
                }
                
                HStack {
                    SignInWithAppleView()
                    CustomGoogleSignInButtonShort()
                        .signInSignUpButtonStyle()
                    
                }
                // MARK: PART: 9
                // I commit this variant because this variant doesn't update the view when a user changes colorScheme.
                //                GoogleSignInButton()
                //                    .frame(maxWidth: 360, alignment: .center)
                //                    .frame(height: 45)
                //                    .onTapGesture {
                //                        myAppVM.googleSignIn()
                //                    }
                // This custom system Button, I commit because I use short variant.
                //    CustomGoogleSignInButton() 
            } .frame(
                minWidth: 0,
                maxWidth: .infinity)
            .padding(.top, 20)
            .navigationTitle("")
        }
    }
}

struct MainLoginView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoginView()
    }
}
