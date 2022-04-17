//
//  UserPostRequestView.swift
//  URLSessionAndPOSTRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/16/22.
//

import SwiftUI

struct UserPostRequestView: View {
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
                Button("POST Request & @escaping") {
                    postAppVM.runUserPOSTRequestEscaping()
                }
                Button("POST Request & async/await") {
                    Task {
                        await postAppVM.runUserPOSTRequestAsyncAwait()
                    }
                }
                Button("POST Request @escaping & async/await") {
                    Task {
                        await postAppVM.runUserPOSTRequestEscapingAsyncAwait()
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
        }.navigationTitle(Text("POST Request & reqres.in"))
    }
}

struct UserPostRequestView_Previews: PreviewProvider {
    static var previews: some View {
        UserPostRequestView()
            .environmentObject(PostRequestViewModel())
    }
}
