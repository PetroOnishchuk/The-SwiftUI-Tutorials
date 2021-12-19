//
//  OldActionSheetView.swift
//  ConfirmationDialog&SwiftUI01
//
//  Created by Petro Onishchuk on 12/18/21.
//

import SwiftUI

struct OldActionSheetView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State private var newUserName = ""
    @State private var newUserSymbol = ""
    @State private var newUser: User?
    @State private var showActionSheet = false
    
    var body: some View {
        List {
            VStack {
            TextField("Enter username", text: $newUserName)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
            TextField("Enter user symbol", text: $newUserSymbol)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
            Button("Create User") {
                // V.1.0
                let newName = newUserName.trimmingCharacters(in: .whitespaces)
                let newSymbol = newUserSymbol.trimmingCharacters(in: .whitespaces)
                newUser = User(id: UUID(), name: newName, symbol: newSymbol)
                // V.2.0
              //  showActionSheet = true
            }.padding()
                .background(newUserName.isEmpty || newUserSymbol.isEmpty ? Color.gray : Color.blue)
                .foregroundColor(Color.white)
                .clipShape(Capsule())
                .disabled(newUserName.isEmpty || newUserSymbol.isEmpty)
                .buttonStyle(PlainButtonStyle())
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
            ForEach(userVM.listOfUsers, id: \.self){ user in
                HStack {
                    Text(user.name)
                    Spacer()
                    Text(user.symbol)
                }
            }
        }
        // V.1.0
        .actionSheet(item: $newUser, content: { user in
            ActionSheet(title: Text("Create a New User"), message: Text("Do you want to create a new user with name: \(user.name)"), buttons: [
                .default(Text("Create User"), action: {
                    userVM.appendNewUser(user)
                    userVM.cleanUsersFields(name: $newUserName, symbol: $newUserSymbol, newUser: $newUser)
                }),
                .destructive(Text("Forget this user"), action: {
                    userVM.cleanUsersFields(name: $newUserName, symbol: $newUserSymbol, newUser: $newUser)
                }),
                .cancel(Text("Cancel"))
            ])
        })
        // V.2.0
//        .actionSheet(isPresented: $showActionSheet, content: {
//            ActionSheet(title: Text("Create a New User"), message: Text("Do you want to create a new user with name: \(newUserName)"), buttons: [
//                .default(Text("Create user"), action: {
//                    let newName = newUserName.trimmingCharacters(in: .whitespaces)
//                    let newSymbol = newUserSymbol.trimmingCharacters(in: .whitespaces)
//                    let newUser = User(id: UUID(), name: newName, symbol: newSymbol)
//                    userVM.appendNewUser(newUser)
//                    userVM.cleanUsersFields(name: $newUserName, symbol: $newUserSymbol, newUser: $newUser)
//                }),
//                .destructive(Text("Forget this user"), action: {
//                    userVM.cleanUsersFields(name: $newUserName, symbol: $newUserSymbol, newUser: $newUser)
//                }),
//                .cancel(Text("Cancel"))
//            ])
//        })
        .navigationTitle(Text("Old Action Sheet & SwiftUI"))
    }
}

struct OldActionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        OldActionSheetView()
    }
}
