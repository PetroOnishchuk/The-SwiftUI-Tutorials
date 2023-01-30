//
//  UserView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 12/23/22.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    
    var body: some View {
        List {
            Section {
                Text(myAppVM.mainUser.firstName)
                Text(myAppVM.mainUser.lastName)
            } header: {
                Text("First Name and Last Name Section")
            }
            Section {
                Text(myAppVM.mainUser.email)
            } header: {
                Text("Email")
            }
            Section {
                NavigationLink(value: myAppVM.mainUser) {
                    Text("Edit User")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } header: {
                Text("Edit User Section")
            }
        }.toolbar {
            ToolbarItem {
                Button {
                    myAppVM.signOut()
                } label: {
                    Text("SignOut")
                }
            }
        }
        .navigationTitle("Users Screen")
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
