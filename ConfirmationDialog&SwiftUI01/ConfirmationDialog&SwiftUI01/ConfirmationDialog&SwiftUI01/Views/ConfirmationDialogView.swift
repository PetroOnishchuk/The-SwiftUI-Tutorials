//
//  ConfirmationDialogView.swift
//  ConfirmationDialog&SwiftUI01
//
//  Created by Petro Onishchuk on 12/18/21.
//

import SwiftUI

struct ConfirmationDialogView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State private var newUserName = ""
    @State private var newUserSymbol = ""
    @State private var newUser: User?
    @State private var showConfirmationDialog = false
    
    var body: some View {
        List {
            VStack {
                TextField("Enter username", text: $newUserName)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                TextField("Enter user symbol", text: $newUserSymbol)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                Button("Create User") {
                    let newName = newUserName.trimmingCharacters(in: .whitespaces)
                    let newSymbol = newUserSymbol.trimmingCharacters(in: .whitespaces)
                    newUser = User(id: UUID(), name: newName, symbol: newSymbol)
                    showConfirmationDialog = true
                }
                .padding()
                .background(newUserName.isEmpty || newUserSymbol.isEmpty ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .disabled(newUserName.isEmpty || newUserSymbol.isEmpty)
                .buttonStyle(PlainButtonStyle())
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
            ForEach(userVM.listOfUsers, id: \.self) {
                user in
                HStack {
                    Text(user.name)
                    Spacer()
                    Text(user.symbol)
                }
            }
        }.confirmationDialog(Text("Create a New User"), isPresented: $showConfirmationDialog, titleVisibility: .visible, presenting: newUser, actions: { user in
            Button("Save User") {
                userVM.appendNewUser(user)
                userVM.cleanUsersFields(name: $newUserName, symbol: $newUserSymbol, newUser: $newUser)
            }
            Button("Forget this user", role: .destructive) {
                userVM.cleanUsersFields(name: $newUserName, symbol: $newUserSymbol, newUser: $newUser)
            }
             
        }, message: { user in
            Text("Do you want to create user with name: \(user.name)")
        })
        .navigationTitle(Text("Confirmation Dialog & SwiftUI"))
    }
}

struct ConfirmationDialogView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationDialogView()
    }
}
