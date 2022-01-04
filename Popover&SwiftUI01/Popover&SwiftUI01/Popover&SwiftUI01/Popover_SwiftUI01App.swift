//
//  Popover_SwiftUI01App.swift
//  Popover&SwiftUI01
//
//  Created by Petro Onishchuk on 1/4/22.
//

import SwiftUI

@main
struct Popover_SwiftUI01App: App {
    @StateObject var projectImageVM = ProjectImageViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(projectImageVM)
        }
    }
}
