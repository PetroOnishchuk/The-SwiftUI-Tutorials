//
//  SwiftUIandAmazonSNSPushApp.swift
//  SwiftUIandAmazonSNSPush
//
//  Created by Petro Onishchuk on 8/7/22.
//

import SwiftUI

@main
struct SwiftUIandAmazonSNSPushApp: App {
    
    //MARK: AppDelegate
    // for work with AppDelegate.swift file
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    //Setup View Model
    @StateObject var notificationAppVM = NotificationAppVM()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(notificationAppVM)
        }
    }
}
