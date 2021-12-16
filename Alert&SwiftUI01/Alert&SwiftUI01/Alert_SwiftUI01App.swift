//
//  Alert_SwiftUI01App.swift
//  Alert&SwiftUI01
//
//  Created by Petro Onishchuk on 12/14/21.
//

import SwiftUI

@main
struct Alert_SwiftUI01App: App {
    @StateObject var userVM = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            AlertMainView()
                .environmentObject(userVM)
        }
    }
}
