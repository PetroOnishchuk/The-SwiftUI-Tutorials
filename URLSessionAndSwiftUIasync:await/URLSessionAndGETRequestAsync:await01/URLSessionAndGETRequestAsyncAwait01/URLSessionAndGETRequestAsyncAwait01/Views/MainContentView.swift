//
//  MainContentView.swift
//  URLSessionAndGETRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/12/22.
//

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var getAppVM: GetAppViewModel
    
    var body: some View {
        NavigationView {
            Form {
                NavigationLink {
                    SingleUserRequestView()
                } label: {
                    Text("User GET Request")
                }
                NavigationLink {
                      PageRequestView()
                } label: {
                    Text("Page GET Request")
                }
                NavigationLink {
                    LocalUsersView()
                } label: {
                    Text("Users Get Request & LocalHost")
                }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Text("GET Request & @escaping & async/await"))
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
