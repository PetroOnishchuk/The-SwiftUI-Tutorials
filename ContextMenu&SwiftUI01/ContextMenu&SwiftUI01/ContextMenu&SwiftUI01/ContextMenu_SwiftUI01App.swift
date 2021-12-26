//
//  ContextMenu_SwiftUI01App.swift
//  ContextMenu&SwiftUI01
//
//  Created by Petro Onishchuk on 12/24/21.
//

import SwiftUI

@main
struct ContextMenu_SwiftUI01App: App {
    @StateObject var projectImageVM = ProjectImageViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(projectImageVM)
                
        }
    }
}
