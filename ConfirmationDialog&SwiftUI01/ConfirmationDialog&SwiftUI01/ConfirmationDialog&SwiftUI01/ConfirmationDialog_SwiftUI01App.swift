//
//  ConfirmationDialog_SwiftUI01App.swift
//  ConfirmationDialog&SwiftUI01
//
//  Created by Petro Onishchuk on 12/18/21.
//

import SwiftUI

@main
struct ConfirmationDialog_SwiftUI01App: App {
    @StateObject var userVM = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainConfirmationDialogView()
                .environmentObject(userVM)
        }
    }
}
