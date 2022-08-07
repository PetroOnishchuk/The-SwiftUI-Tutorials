//
//  NotificationAppVM.swift
//  SwiftUIandAmazonSNSPush
//
//  Created by Petro Onishchuk on 8/7/22.
//

import Foundation
import SwiftUI

class NotificationAppVM: ObservableObject {
    @Published var allMessages = [Message]()
    
    
    //MARK: Take Notifications
    // Take notifications from NotificationCenter
    
    func setupNotifications() {
        print("Hello NOT")
        let notificationName = Notification.Name(NotificationNameValue.pushNotification.rawValue)
  //start to listening our notification
            // from NotificationCenter
        
        NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: .main) { [weak self] notification in
            
            self?.convertNotificationMessage(userInfo: notification.object)
                
            
            
        }
    }
    
    
   
    //MARK: Convert message for display in App
    func convertNotificationMessage(userInfo: Any?) {
        print("Convert NOT")
        // V 2.0
        // through NSDictionary
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
        }
        
         
    }
    
    //Clean list
    @MainActor
    func cleanMessageList() {
        allMessages = []
    }
    
    //Work with Date
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    
    func convertDate(date: Date) -> String {
        return itemFormatter.string(from: date)
    }
}
