//
//  UsersView.swift
//  URLSessionGenericAndDatabaseiOS01
//
//  Created by Petro Onishchuk on 6/2/22.
//

import SwiftUI

struct UsersView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    @State var updateUser = false
    
    var body: some View {
        List {
            Section {
                TextField("ID", text: $myAppVM.userID)
                TextField("First Name", text: $myAppVM.firstName)
                Button("Find Single User") {
                    Task {
                        await myAppVM.runSelectSingleUserPOSTRequestAsyncAwaitAndGeneric()
                        myAppVM.typeOfSearch =  .singleSearch
                    }
                }
                .disabled(myAppVM.checkFindFields())
                Button("Find multiple Users") {
                    Task {
                        await myAppVM.runSelectMultipleUsersPOSTRequestAsyncAwaitAndGeneric()
                        myAppVM.typeOfSearch = .multipleSearch
                    }
                }
                .disabled(myAppVM.checkFindFields())
                Button(role: .destructive) {
                    myAppVM.cleanNewAndUpdateUserFields()
                } label: {
                    Text("Clean Text Fields")
                }
                Button(role: .destructive) {
                    myAppVM.cancelSearchUser()
                } label: {
                    Text("Cancel")
                }
            } header: {
                Text("Find User Section")
            }
            Section {
                Button("GET All Users & LocalHost") {
                    Task {
                        await myAppVM.runAllUsersGETRequestAsyncAwaitGenericLocalHost()
                    }
                }
                Button(role: .destructive) {
                    myAppVM.cleanAllUsers()
                } label: {
                    Text("Clean Users List")
                }
            } header: {
                Text("GET All Users Section")
            }
            Section {
                ForEach(myAppVM.allUsers) {
                    user in
                    SingleUserView(user: user)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            myAppVM.setUserForUpdate(selectedUser: user)
                            updateUser = true
                        }
                }
                .onDelete(perform: myAppVM.deleteItem(at:))
            } header: {
                Text("Users List Section")
            }
        }.navigationTitle("Users & LocalHost")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        NewUserView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $updateUser, onDismiss: nil) {
                UpdateUserView()
            }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
            .environmentObject(MyAppViewModel())
    }
}
