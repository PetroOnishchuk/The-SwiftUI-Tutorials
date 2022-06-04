//
//  UpdateUserView.swift
//  URLSessionGenericAndDatabaseiOS01
//
//  Created by Petro Onishchuk on 6/2/22.
//

import SwiftUI

struct UpdateUserView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        List {
            Section {
                Text("ID: \(myAppVM.userID)  #CAN'T CHANGE#")
                TextField("First Name", text: $myAppVM.firstName)
                TextField("Last Name", text: $myAppVM.lastName)
                TextField("Email", text: $myAppVM.email)
                TextField("Avatar", text: $myAppVM.avatar)
            } header: {
                Text("Text Fields Section")
            }
            Section {
                Button("Update Selected User") {
                    Task {
                        await myAppVM.runUpdateUserPOSTRequestAsyncAwaitAndGeneric()
                        switch myAppVM.typeOfSearch {
                        case .multipleSearch:
                            await myAppVM.runSelectMultipleUsersPOSTRequestAsyncAwaitAndGeneric()
                        case .singleSearch:
                            await myAppVM.runSelectSingleUserPOSTRequestAsyncAwaitAndGeneric()
                        case .off:
                            await myAppVM.runAllUsersGETRequestAsyncAwaitGenericLocalHost()
                        }
                        presentation.wrappedValue.dismiss()
                    }
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
        }.navigationTitle("Update User with ID: \(myAppVM.userID)")
    }
}

struct UpdateUserView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUserView()
    }
}
