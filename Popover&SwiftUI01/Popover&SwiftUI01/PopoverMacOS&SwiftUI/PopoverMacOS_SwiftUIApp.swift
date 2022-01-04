//
//  PopoverMacOS_SwiftUIApp.swift
//  PopoverMacOS&SwiftUI
//
//  Created by Petro Onishchuk on 1/4/22.
//

import SwiftUI

@main
struct PopoverMacOS_SwiftUIApp: App {
    @StateObject var projectImageVM = ProjectImageViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainMacOSContentView()
                .environmentObject(projectImageVM)
        }
    }
}
