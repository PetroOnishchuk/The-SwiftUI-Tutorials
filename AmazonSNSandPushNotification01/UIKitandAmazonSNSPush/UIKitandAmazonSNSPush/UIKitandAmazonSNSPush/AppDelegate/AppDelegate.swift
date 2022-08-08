//
//  AppDelegate.swift
//  UIKitandAmazonSNSPush
//
//  Created by Petro Onishchuk on 8/8/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //MARK: Setup UNUserNotificationCenter
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { granted, error in
            guard granted else {
                print("Don't have Notifications")
                return
            }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        // Show when app is running
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //MARK: Work with NotificationCenter
    //MARK: Take our Notification
    // take our Notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        
        // This constant hold notifications data
        let userInfo = notification.request.content.userInfo
        
        // POST our Notification data
        // through NotificationCenter
        
        let notificationName = Notification.Name(rawValue: NotificationNameValue.pushNotification.rawValue)
        NotificationCenter.default.post(name: notificationName, object: userInfo)
        
        
        //MARK: Display notification
        //For Display notifications in App
        if UIApplication.shared.applicationState == .active {
            return UNNotificationPresentationOptions.init(arrayLiteral: [.badge, .banner, .sound])
        } else {
            return UNNotificationPresentationOptions.init(arrayLiteral: [.badge, .banner, .sound])
        }
    }
    
    
    //MARK: Device Token
    // Take unique Toke for each physical device.
    // Need for setup Amazon Simple Notification Service
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.reduce("") { partialResult, uintNum in
            partialResult + String(format: "%02x", uintNum)
        }
        
        print("DEVICE TOKEN: \(token)\n")
    }
    
    //MARK: Work with Error
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Remote Notification Error Description: \(error.localizedDescription)")
    }
    
    
    
}

