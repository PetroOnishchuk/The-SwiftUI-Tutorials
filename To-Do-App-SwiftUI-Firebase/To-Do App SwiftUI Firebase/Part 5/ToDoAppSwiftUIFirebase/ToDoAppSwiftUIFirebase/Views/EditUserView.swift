//
//  EditUserView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 1/13/23.
//

import SwiftUI

struct EditUserView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    @Environment(\.dismiss) var dismiss
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    var body: some View {
        List {
            Section {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
            } header: {
                Text("Update First Name and Last Name Section")
            }
            Section {
                Button {
                    myAppVM.updateUserData(firstName: firstName, lastName: lastName)
                } label: {
                    Text("Update User")
                        .frame(maxWidth: .infinity, alignment: .center)
                }.disabled(firstName.isEmpty || lastName.isEmpty)
            }
            Section {
                TextField("Email", text: $email)
            } header: {
                Text("Edit Email Section")
            }
            Section {
                Button {
                    myAppVM.updateUsersEmailAuth(email: email)
                } label: {
                    Text("Update Email")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }.toolbar(content: {
            Button("Dismiss") {
                dismiss()
            }
        })
        .navigationTitle("Edit User Screen")
    }
}

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserView()
    }
}
