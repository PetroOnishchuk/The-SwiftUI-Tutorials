//
//  NotificationExtensionMVC.swift
//  UIKitAndFirebaseAndPushNotifications01
//
//  Created by Petro Onishchuk on 8/27/22.
//

import Foundation
import UIKit

extension MainViewController {
    //MARK: Setup Notification
    
    func setupNotification() {
        // Add Observer to Firebase Notification
        let firebaseNotName = Notification.Name(NotificationNameValue.firebasePushNotification.rawValue)
        
        NotificationCenter.default.addObserver(forName: firebaseNotName, object: nil, queue: .main) { [weak self] notification in
            
            
            self?.convertNotificationsMessage(notificationObject: notification.object)
        }
    }
    
    //MARK: Convert notifications messages for display in App
    
    func convertNotificationsMessage(notificationObject: Any?) {
        
        guard let wholeMessage = notificationObject as? NSDictionary else {
            print("Error with convert to NSDictionary")
            return
        }
        
        guard let apsMessage = wholeMessage.value(forKey: "aps") as? [String: Any] else {
            print("Error with take APS Value")
            return
        }
        guard let alertMessage = apsMessage["alert"] as? [String: String] else {
            print("Error with convert to alertMessage")
            return
        }
        let title = alertMessage["title"] ?? "No title Value"
        let body = alertMessage["body"] ?? "No body value"
        let newMessage = Message(id: UUID(), title: title, body: body, messagesDate: Date())
        
        DispatchQueue.main.async {
            [weak self] in self?.allMessages.append(newMessage)
            self?.messagesTableView.reloadData()
        }
    }
}
