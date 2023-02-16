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
                    case "setting":
                        UserView()
                    default: Text("Default View")
                    }
                }.navigationDestination(for: Task.self, destination: { task in
                    EditTaskView(taskText: task.text, task: task)
                })
                .navigationDestination(for: User.self, destination: { user in
                    EditUserView(firstName: user.firstName, lastName: user.lastName, email: user.email)                })
                .alert(myAppVM.customAlertInfo.title, isPresented: $myAppVM.isPresentAlert, actions: {
                    // action
                }, message: {
                    Text(myAppVM.customAlertInfo.description)
                })
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
