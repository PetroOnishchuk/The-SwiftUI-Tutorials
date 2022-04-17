//
//  LocalUserPOSTRequestView.swift
//  URLSessionAndPOSTRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/17/22.
//

import SwiftUI

struct LocalUserPOSTRequestView: View {
    @EnvironmentObject var postAppVM: PostRequestViewModel
    
    var body: some View {
        List {
            DetailUserView()
            
            Section {
                TextField("Name", text: $postAppVM.name)
                TextField("Job", text: $postAppVM.job)
            } header: {
                Text("TextFields Section")
            }.textInputAutocapitalization(.never)
            
            Section {
                Button("POST Request & Local Server") {
                    Task {
                        await postAppVM.runUserPOSTRequestAndLocalHost()
                    }
                }
                Button(role: .destructive) {
                    postAppVM.cleanUsersFields()
                } label: {
                    Text("Clean Users Fields")
                }

            } header: {
                Text("Button Section")
            }
        }.navigationTitle(Text("POST Request & Local Server"))
    }
}

struct LocalUserPOSTRequestView_Previews: PreviewProvider {
    static var previews: some View {
        LocalUserPOSTRequestView()
            .environmentObject(PostRequestViewModel())
    }
}
