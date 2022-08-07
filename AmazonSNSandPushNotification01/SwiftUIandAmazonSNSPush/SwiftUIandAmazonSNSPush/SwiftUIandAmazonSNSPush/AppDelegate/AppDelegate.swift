//
//  AppDelegate.swift
//  SwiftUIandAmazonSNSPush
//
//  Created by Petro Onishchuk on 8/7/22.
//

import Foundation
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    //MARK: application didFinishLaunchingWithOptions
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
      // MARK: Request notifications
        // Request permission to use notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { granted, error in
            guard granted else {
                print("Don't have Notifications")
                return
            }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
       //MARK: Work with Notification
        // Work with UNUserNotificationCenter
        // Show Notification when app is Open
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        return true
    }
    
    //MARK: Take our Notification
    // take our Notifications
      func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
          
          // This constant hold notifications data
        let userInfo = notification.request.content.userInfo
        
         // POST our Notification data
          // through NotificationCenter
          
          let notificationName = Notification.Name(rawValue: NotificationNameValue.pushNotification.rawValue)
            NotificationCenter.default.post(name: notificationName, object: userInfo)
       
        
        //MARK: Display notification
          //For Display notifications in App
        if UIApplication.shared.applicationState == .active {
            completionHandler( [.badge, .banner,.sound])
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
