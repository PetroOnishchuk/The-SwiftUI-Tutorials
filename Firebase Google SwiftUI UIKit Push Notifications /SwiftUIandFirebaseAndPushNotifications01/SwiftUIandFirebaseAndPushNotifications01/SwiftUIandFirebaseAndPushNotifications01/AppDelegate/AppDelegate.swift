//
//  AppDelegate.swift
//  SwiftUIandFirebaseAndPushNotifications01
//
//  Created by Petro Onishchuk on 8/25/22.
//

import Foundation
import SwiftUI
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //MARK: Configuration Firebase
        FirebaseApp.configure()
        //MARK: Set the messaging delegate
        Messaging.messaging().delegate = self
        // MARK: Work with UNUserNotificationCenter
        
        //MARK: Request notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else {
                print("Don't have Notifications")
                return
            }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        //MARK: Show notifications when app is active
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        return true
    }
    
    // MARK: Fetching the current registration token
    // MARK: didReceiveRegistrationToken
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        let tokenDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name(NotificationNameValue.FCMTTokenNotifications.rawValue), object: tokenDict, userInfo: nil)
        
        Messaging.messaging().token { token, error in
            if let error {
                print("Error fetching FCM registration token. Error: \(error)")
            } else if let token = token {
                print("FMC registration token: \(token)")
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
        NotificationCenter.default.post(name: Notification.Name(NotificationNameValue.firebasePushNotification.rawValue), object: notificationObject)
        
        //MARK: Display Notifications
        if UIApplication.shared.applicationState == .active {
            return UNNotificationPresentationOptions.init(arrayLiteral: [.badge, .sound, .banner])
        } else {
            return UNNotificationPresentationOptions.init(arrayLiteral: [.badge, .sound, .banner])
        }
    }
    
    // MARK: didFailToRegisterForRemoteNotificationsWithError
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Fail to register for Remote Notifications witj Error: \(error.localizedDescription)")
    }
}
