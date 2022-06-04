//
//  URLSessionGenericAndDatabaseiOS01App.swift
//  URLSessionGenericAndDatabaseiOS01
//
//  Created by Petro Onishchuk on 6/2/22.
//

import SwiftUI

@main
struct URLSessionGenericAndDatabaseiOS01App: App {
    @StateObject var myAppVM = MyAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(myAppVM)
        }
    }
}
