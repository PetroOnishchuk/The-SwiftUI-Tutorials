//
//  MainContentView.swift
//  URLSessionGenericAndDatabaseiOS01
//
//  Created by Petro Onishchuk on 6/2/22.
//

import SwiftUI 

struct MainContentView: View {
    var body: some View {
        NavigationView {
            Form {
                NavigationLink {
                    UsersView()
                } label: {
                    Text("Users GET & POST Request & LocalHost")
                }
                NavigationLink {
                   PageView()
                } label: {
                    Text("Page GET Request & REQRES API")
                }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("GET & POST Request & Database")
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
