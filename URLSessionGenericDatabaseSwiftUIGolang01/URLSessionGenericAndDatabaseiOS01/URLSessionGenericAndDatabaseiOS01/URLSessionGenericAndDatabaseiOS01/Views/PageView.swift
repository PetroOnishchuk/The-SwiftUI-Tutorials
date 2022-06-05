//
//  PageView.swift
//  URLSessionGenericAndDatabaseiOS01
//
//  Created by Petro Onishchuk on 6/2/22.
//

import SwiftUI

struct PageView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    
    var body: some View {
        List {
            Section {
                Button {
                    Task {
                        await myAppVM.runPageGETRequestAsyncAwaitGenericREQRESApi()
                    }
                } label: {
                    Text("GET Page REQRES API")
                }
                Button(role: .destructive) {
                    myAppVM.cleanPageFields()
                } label: {
                    Text("Clean Page Fields")
                }
            } header: {
                Text("Button Section")
            }
            Section {
                Text("Page #\(myAppVM.mainPage.page)")
                Text("Per-page: \(myAppVM.mainPage.perPage)")
                Text("Total: \(myAppVM.mainPage.total)")
                Text("Total pages: \(myAppVM.mainPage.totalPages)")
            } header: {
                Text("Page Info Section")
            }
            Section {
                Text("Text: \(myAppVM.mainPage.support.text)")
                Text("URL: \(myAppVM.mainPage.support.url)")
            } header: {
                Text("Support Section")
            }
            Section {
                ForEach(myAppVM.mainPage.allUsers) {
                     user in
                    SingleUserView(user: user)
                }
            } header: {
                Text("List of Users Section")
            }
        }.navigationTitle("GET Request & REQRES API")
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView().environmentObject(MyAppViewModel())
    }
}
