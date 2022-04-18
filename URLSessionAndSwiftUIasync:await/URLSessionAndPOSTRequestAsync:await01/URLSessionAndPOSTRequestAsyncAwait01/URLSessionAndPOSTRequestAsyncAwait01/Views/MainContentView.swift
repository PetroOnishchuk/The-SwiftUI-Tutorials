//
//  MainContentView.swift
//  URLSessionAndPOSTRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/16/22.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("POST Request with reqres.in") {
                    UserPostRequestView()
                }
                NavigationLink("POST Request with Local Server") {
                    LocalUserPOSTRequestView()
                }
            }.navigationTitle(Text("POST request & @escaping & async/await"))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
            .environmentObject(PostRequestViewModel())
    }
}
