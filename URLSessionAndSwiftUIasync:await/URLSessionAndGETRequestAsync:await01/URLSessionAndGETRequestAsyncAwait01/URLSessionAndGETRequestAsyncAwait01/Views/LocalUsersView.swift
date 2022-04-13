//
//  LocalUsersView.swift
//  URLSessionAndGETRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/13/22.
//

import SwiftUI

struct LocalUsersView: View {
    @EnvironmentObject var getAppViewModel: GetAppViewModel
    
    var body: some View {
        List {
            Section {
                Button {
                    Task {
                        await getAppViewModel.runUsersGetRequestAsyncAwaitLocal()
                    }
                } label: {
                    Text("async/await & GET Request")
                }
                Button(role: .destructive) {
                    getAppViewModel.cleanPageFields()
                } label: {
                    Text("Clean Users Fields")
                }

            } header: {
                Text("Button Section")
            }
            Section {
                ForEach(getAppViewModel.mainPage.allUsers) { user in
                    SingleUserView(user: user)
                }
                
            } header: {
                Text("Users List Section")
            }
            
        }.navigationTitle(Text("Get Request & LocalHost"))
    }
}

struct LocalUsersView_Previews: PreviewProvider {
    static var previews: some View {
        LocalUsersView()
            .environmentObject(GetAppViewModel())
    }
}
