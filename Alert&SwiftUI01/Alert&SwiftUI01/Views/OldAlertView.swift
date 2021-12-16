//
//  OldAlertView.swift
//  Alert&SwiftUI01
//
//  Created by Petro Onishchuk on 12/14/21.
//

import SwiftUI

struct OldAlertView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @State private var newUserName = ""
    @State private var newUserSymbol = ""
    @State private var newUserObject: User?
    @State private var showAlert = false
    var body: some View {
        List {
            VStack {
                TextField("Enter username", text: $newUserName)
                    .padding()
                TextField("Enter user symbol", text: $newUserSymbol)
                    .padding()
                Button("Create User") {
                 // let name = newUserName.trimmingCharacters(in: .whitespaces)
                    // newUserObject = User(id: UUID(), name: name, symbol: newUserSymbol)
                    showAlert = true
                }.padding()
                    .background(newUserName.isEmpty || newUserSymbol.isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .disabled(newUserName.isEmpty || newUserSymbol.isEmpty)
            }.padding()
            ForEach(userVM.listOfUsers, id: \.self) {
                user in
                HStack {
                    Text(user.name)
                    Spacer()
                    Text(user.symbol)
                }
            }
            
        }.navigationTitle(Text("Old Alert & SwiftUI"))
        //            .alert(item: $newUserObject) { user in
        //                Alert(title: Text("Save User \(user.name)"), message: Text("Save user \(user.name)?"), primaryButton: .default(Text("Save"), action: {
        //                    let name = newUserName.trimmingCharacters(in: .whitespaces)
        //                    let newUser = User(id: UUID(), name: name, symbol: newUserSymbol)
        //                    userVM.appendNewUser(newUser)
        //                    userVM.cleanNameAndSymbol(name: $newUserName, symbol: $newUserSymbol)
        //                }), secondaryButton: .destructive(Text("Cancel"), action: {
        //                    userVM.cleanNameAndSymbol(name: $newUserName, symbol: $newUserSymbol)
        //                }))
        //            }
        // V. 2.0
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Save User \(newUserName)"), message: Text("Save user \(newUserName)?"), primaryButton: .default(Text("Save"), action: {
                    let name = newUserName.trimmingCharacters(in: .whitespaces)
                    let newUser = User(id: UUID(), name: name, symbol: newUserSymbol)
                    userVM.appendNewUser(newUser)
                    userVM.cleanNameAndSymbol(name: $newUserName, symbol: $newUserSymbol)
                }), secondaryButton: .destructive(Text("Cancel"), action: {
                    userVM.cleanNameAndSymbol(name: $newUserName, symbol: $newUserSymbol)
                }))
            }
    }
}

struct OldAlertView_Previews: PreviewProvider {
    static var previews: some View {
        OldAlertView()
    }
}
