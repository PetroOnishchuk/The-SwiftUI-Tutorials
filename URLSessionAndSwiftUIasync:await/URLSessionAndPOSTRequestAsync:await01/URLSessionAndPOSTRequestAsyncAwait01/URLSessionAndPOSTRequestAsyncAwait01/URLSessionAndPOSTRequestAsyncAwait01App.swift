//
//  URLSessionAndPOSTRequestAsyncAwait01App.swift
//  URLSessionAndPOSTRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/16/22.
//

import SwiftUI

@main
struct URLSessionAndPOSTRequestAsyncAwait01App: App {
    
    @StateObject var posAppVM = PostRequestViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(posAppVM)
        }
    }
}
