//
//  PageRequestView.swift
//  URLSessionAndGETRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/13/22.
//

import SwiftUI

struct PageRequestView: View {
    
    
    @EnvironmentObject var getAppViewModel: GetAppViewModel
    
    var body: some View {
        List {
            Section {
                Text("Page #\(getAppViewModel.mainPage.page)")
                Text("Per-page: \(getAppViewModel.mainPage.perPage)")
                Text("Total: \(getAppViewModel.mainPage.total)")
                Text("Total pages: \(getAppViewModel.mainPage.totalPages)")
            } header: {
                Text("Page Info Section")
            }
            Section {
                Text("S/T: \(getAppViewModel.mainPage.support.text)")
                Text("S/T: \(getAppViewModel.mainPage.support.url)")
            } header: {
                Text("Support Info Section")
            }
            Section {
                Button {
                    getAppViewModel.runPageGetRequestEscaping()
                } label: {
                    Text("@escaping & GET Request")
                }
                Button {
                    Task {
                        await getAppViewModel.runPageGetRequestAsyncAwait()
                    }
                } label: {
                    Text("async/await & GET Request")
                }
                Button {
                    Task {
                        await getAppViewModel.runPageGetRequestEscapingAndAsyncAwait()
                    }
                } label: {
                    Text("async/await & @escaping & GET Request")
                }
                Button(role: .destructive) {
                    getAppViewModel.cleanPageFields()
                } label: {
                    Text("Clean Page fields")
                }
            } header: {
                Text("Button Section")
            }
            Section {
                ForEach(getAppViewModel.mainPage.allUsers) { user in
                    SingleUserView(user: user)
                }
            } header: {
                Text("List of Users Section")
            }
            
        }.navigationTitle(Text("Page GET Request"))
    }
}

struct PageRequestView_Previews: PreviewProvider {
    static var previews: some View {
        PageRequestView()
            .environmentObject(GetAppViewModel())
    }
}
