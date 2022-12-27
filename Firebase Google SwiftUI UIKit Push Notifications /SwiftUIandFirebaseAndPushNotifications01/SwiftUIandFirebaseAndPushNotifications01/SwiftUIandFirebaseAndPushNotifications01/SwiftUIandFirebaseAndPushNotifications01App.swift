//
//  SwiftUIandFirebaseAndPushNotifications01App.swift
//  SwiftUIandFirebaseAndPushNotifications01
//
//  Created by Petro Onishchuk on 8/25/22.
//

import SwiftUI

@main
struct SwiftUIandFirebaseAndPushNotifications01App: App {
    
    @StateObject var myAppVM = MyAppViewModel()
    
    //MARK: AppDelegate
    // work with AppDelegate.swift
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(myAppVM)
        }
    }
}
