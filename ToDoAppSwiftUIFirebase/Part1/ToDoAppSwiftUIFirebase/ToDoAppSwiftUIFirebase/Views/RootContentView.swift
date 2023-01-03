//
//  RootContentView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 12/23/22.
//

import SwiftUI

struct RootContentView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    
    var body: some View {
        NavigationStack(path: $myAppVM.path) {
            SelectedContentView()
                .navigationDestination(for: String.self) { value in
                    switch value {
                    case "signIn":
                        SignInView()
                    case "signUp":
                        SignUpView()
                    default: Text("Default View")
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    myAppVM.isUserSignedIn()
                }
        }
    }
}

struct RootContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootContentView()
    }
}
