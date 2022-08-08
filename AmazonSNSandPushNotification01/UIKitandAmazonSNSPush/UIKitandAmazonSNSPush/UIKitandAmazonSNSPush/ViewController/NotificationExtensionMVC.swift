//
//  NotificationExtensionMVC.swift
//  UIKitandAmazonSNSPush
//
//  Created by Petro Onishchuk on 8/8/22.
//

import Foundation
import UIKit

extension MainViewController {
    
    //MARK: Take Notifications
    // Take notifications from NotificationCenter
    func setupNotifications() {
        let notificationName = Notification.Name(NotificationNameValue.pushNotification.rawValue)
        
        //start to listening our notification
        // from NotificationCenter
        NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: .main) { [weak self] notification in
            
            self?.convertNotificationMessage(userInfo: notification.object)
            
        }
    }
    
    //MARK: Convert message for display in App
    func convertNotificationMessage(userInfo: Any?) {
        
        // Work with Data through NSDictionary
        guard let aps = userInfo as? NSDictionary else {
            print("Convert to NSDictionary Error")
            return
        }
        
        guard let alertMessage = aps.value(forKey: "aps") as? [String: String] else {
            print("Take aps value error")
            return
        }
        let alert = alertMessage["alert"] ?? "No alert value"
        let description = alertMessage["description"] ?? "No description value"
        
        let newMessage = Message(id: UUID(), title: alert, description: description, massageDate: Date())
        print("New Message \(newMessage)")
        DispatchQueue.main.async {
            [weak self] in
            self?.allMessages.append(newMessage)
            self?.messagesTableView.reloadData()
        }
    }
    
   
    
    func convertDate(date: Date) -> String {
        return itemFormatter.string(from: date)
    }
}

