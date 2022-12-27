//
//  MyAppViewModel.swift
//  SwiftUIandFirebaseAndPushNotifications01
//
//  Created by Petro Onishchuk on 8/25/22.
//

import Foundation
import SwiftUI

class MyAppViewModel: ObservableObject {
    @Published var allMessages = [Message]()
    
    //MARK: Work with Date
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle  = .medium
        return formatter
    }()
    
    func convertData(date: Date) -> String {
        return itemFormatter.string(from: date)
    }
    
    //MARK: Clean allMessage List
    @MainActor
    func cleanAllMessageList() {
        allMessages = []
    }
    
    //MARK: Setup Notifications
    func setupNotifications() {
        //MARK: add Observer to Firebase Notifications
        
        let firebaseNotName = Notification.Name(NotificationNameValue.firebasePushNotification.rawValue)
        
        NotificationCenter.default.addObserver(forName: firebaseNotName, object: nil, queue: .main) { notification in
            
            self.convertNotificationsMessage(notificationObject: notification.object)
            
        }
    }
    
    //MARK: Convert notification message for display in App
    
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
        print("NEW MEssage")
        
        DispatchQueue.main.async {
            [weak self] in
            self?.allMessages.append(newMessage)
        }
        
        
    }
}

