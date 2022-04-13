//
//  URLSessionAndGETRequestAsyncAwait01App.swift
//  URLSessionAndGETRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/12/22.
//

import SwiftUI

@main
struct URLSessionAndGETRequestAsyncAwait01App: App {
    @StateObject var getAppVM = GetAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(getAppVM)
        }
    }
}
