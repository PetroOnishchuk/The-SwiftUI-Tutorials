//
//  NewAlertView.swift
//  Alert&SwiftUI01
//
//  Created by Petro Onishchuk on 12/14/21.
//

import SwiftUI

struct NewAlertView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State private var newUserName = ""
    @State private var newUserSymbol = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        List {
            VStack {
                TextField("Enter username", text: $newUserName)
                    .padding()
                TextField("Enter user symbol", text: $newUserSymbol)
                    .padding()
                Button("Create User") {
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
            
        }.navigationTitle(Text("New Alert & SwiftUI"))
            .alert(Text("Create user: \(newUserName)"), isPresented: $showAlert) {
                Button("Yes") {
                    let name = newUserName.trimmingCharacters(in: .whitespaces)
                    let newUser = User(id: UUID(), name: name, symbol: newUserSymbol)
                    userVM.appendNewUser(newUser)
                    userVM.cleanNameAndSymbol(name: $newUserName, symbol: $newUserSymbol)
                }
                
                Button(role: .destructive) {
                    userVM.cleanNameAndSymbol(name: $newUserName, symbol: $newUserSymbol)
                } label: {
                    Text("Delete this name")
                }
            }
    }
}

struct NewAlertView_Previews: PreviewProvider {
    static var previews: some View {
        NewAlertView()
    }
}
