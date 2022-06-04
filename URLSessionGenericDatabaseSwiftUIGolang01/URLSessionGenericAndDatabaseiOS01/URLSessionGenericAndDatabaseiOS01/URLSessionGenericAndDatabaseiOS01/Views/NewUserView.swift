//
//  NewUserView.swift
//  URLSessionGenericAndDatabaseiOS01
//
//  Created by Petro Onishchuk on 6/2/22.
//

import SwiftUI

struct NewUserView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    @Environment(\.presentationMode) var presentation
    
    
    var body: some View {
        List {
            Section {
                TextField("First Name", text: $myAppVM.firstName)
                TextField("Last Name", text: $myAppVM.lastName)
                TextField("Email", text: $myAppVM.email)
                TextField("Avatar", text: $myAppVM.avatar)
            } header: {
                Text("Text Fields Section")
            }
            
            Section {
                Button {
                    Task {
                        await myAppVM.runInsertNewUserPOSTRequestAsyncAwaitAndGeneric()
                        myAppVM.cleanNewAndUpdateUserFields()
                        await myAppVM.runAllUsersGETRequestAsyncAwaitGenericLocalHost()
                        presentation.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Create New User")
                }
                .disabled(myAppVM.checkNewUserFields())
                Button(role: .destructive) {
                    myAppVM.cleanNewAndUpdateUserFields()
                } label: {
                    Text("Clean Text Fields")
                }

                
                Button(role: .destructive) {
                    myAppVM.cleanNewAndUpdateUserFields()
                    presentation.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }

            } header: {
                Text("Button Section")
            }
        }.navigationTitle("Create New User")
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView()
    }
}
