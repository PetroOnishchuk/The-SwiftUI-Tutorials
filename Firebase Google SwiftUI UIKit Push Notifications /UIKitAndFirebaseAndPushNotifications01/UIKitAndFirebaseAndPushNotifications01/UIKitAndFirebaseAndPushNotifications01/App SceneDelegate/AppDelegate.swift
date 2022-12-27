//
//  AppDelegate.swift
//  UIKitAndFirebaseAndPushNotifications01
//
//  Created by Petro Onishchuk on 8/27/22.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //MARK: Configuration Firebase
        FirebaseApp.configure()
        
        //MARK: Set the messaging delegate
        Messaging.messaging().delegate = self
        
        
        
        //MARK: Work with UNUserNotificationCenter
        
        //MARK: Request notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else {
                print("Don't have Notifications")
                return
            }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        
        // Set Delegate for NotificationCenter
        // For show notification when app is running
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        return true
    }
    
    //MARK: Fetching the current registration token
    // MARK: didReceiveRegistrationToken
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        let tokenDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name(NotificationNameValue.FCMTTokenNotifications.rawValue), object: tokenDict, userInfo: nil)
        
        Messaging.messaging().token { token, error in
            if let error {
                print("Error fetching FCM registration token. Error: \(error)\n")
            } else if let token = token {
                print("FCM registration token: \(token)")
            }
        }
    }
    
    // MARK: didRegisterForRemoteNotificationsWithDeviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // MARK: didReceive UNNotificationResponse
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        
        let userInfo = response.notification.request.content.userInfo
        
        print("Did receive response: \(userInfo)")
    }
    //MARK: willPresent notification async
    // work with our notifications
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        
        let notificationObject = notification.request.content.userInfo
        NotificationCenter.default.post(name: Notification.Name( NotificationNameValue.firebasePushNotification.rawValue), object: notificationObject)
        
        //MARK: Display Notifications
        if UIApplication.shared.applicationState == .active {
            return UNNotificationPresentationOptions.init(arrayLiteral: [.badge, .sound, .banner])
        } else {
            return UNNotificationPresentationOptions.init(arrayLiteral: [.badge, .sound, .banner])
        }
    }
    
    // MARK: didFailToRegisterForRemoteNotificationsWithError
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Remote Notification with Error: \(error.localizedDescription)")
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
    
    
}

