//
//  SingleUserRequestView.swift
//  URLSessionAndGETRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/13/22.
//

import SwiftUI

struct SingleUserRequestView: View {
    @EnvironmentObject var getAppViewModel: GetAppViewModel
    
    var body: some View {
        List {
            Section {
                SingleUserView(user: getAppViewModel.mainUser.user)
            } header: {
                Text("User Data Section")
            }
            Section {
                VStack(alignment: .leading, spacing: 5) {
                    Text("S/T url: \(getAppViewModel.mainUser.support.url)")
                    Text("S/T text: \(getAppViewModel.mainUser.support.text)")
                }
            } header: {
                Text("Support Section")
            }
            Section {
                Button {
                    getAppViewModel.runUserGetRequestEscaping()
                } label: {
                    Text("@escaping & GET Request")
                }
                Button {
                    Task {
                        await getAppViewModel.runUserGetRequestAsyncAwait()
                    }
                } label: {
                    Text("async/await & GET Request")
                }
                Button {
                    Task {
                        await getAppViewModel.runUserGetRequestEscapingAndAsyncAwait()
                    }
                } label: {
                    Text("async/await & @escaping GET Request")
                }
                Button(role: .destructive) {
                    getAppViewModel.cleanUserFields()
                } label: {
                    Text("Clean Users fields")
                }

                
            } header: {
                Text("Button Section")
            }
            
        }.navigationTitle(Text("Single User Get Request"))
    }
}

struct SingleUserRequestView_Previews: PreviewProvider {
    static var previews: some View {
        SingleUserRequestView()
            .environmentObject(GetAppViewModel())
    }
}
