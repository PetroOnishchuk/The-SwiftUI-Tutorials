
# SwiftUI Project & Amazon Simple Notification Service
## Push Notifications

## [Apple Developer](https://developer.apple.com)
## [AWS](https://aws.amazon.com)

## 1. Setup Xcode Project. 
### 1.1 Start new Xcode Project (my is SwiftUIandAmazonSNSPush).

### 1.2. Add capability (Background modes Push Notification).  
 ![SwiftUITutorials001.jpeg](images/SwiftUITutorials001.jpeg) 
  ![SwiftUITutorials002.jpeg](images/SwiftUITutorials002.jpeg) 
   ![SwiftUITutorials003.jpeg](images/SwiftUITutorials003.jpeg) 
    ![SwiftUITutorials004.jpeg](images/SwiftUITutorials004.jpeg)  
        ![SwiftUITutorials005.jpeg](images/SwiftUITutorials005.jpeg) 
 
 ### 1.3. Fill our project  
 Create MessageModel.swift.
 Code:  
 
 ```Swift
 //
//  MessageModel.swift
//  SwiftUIandAmazonSNSPush
//
//  Created by Petro Onishchuk on 8/7/22.
//

import Foundation

struct Message: Identifiable, Hashable {
    var id: UUID
    var title: String
    var description: String
    var massageDate: Date
}

enum  NotificationNameValue: String {
    case pushNotification = "pushNotification"
}

 ```
 
 ### 1.4. Create AppDelegate.swift file, for setup and work with UNUserNotificationCenter.  
 Also, in AppDelegate.swift we have func, for work Device Token. Don't forget!!!
 
 Code: 
 ```Swift
     //MARK: Device Token
    // Take unique Toke for each physical device.
    // Need for setup Amazon Simple Notification Service
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.reduce("") { partialResult, uintNum in
            partialResult + String(format: "%02x", uintNum)
        }
        
        print("DEVICE TOKEN: \(token)\n")
    }
    
 ```
 
 Code:   
 ```Swift
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

 ```
 
 ### 1.5. Create ViewModel:NotificationAppVM.swift, to work with Notifications and display notifications on the list.  
  
 Code:  
 ```Swift 
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

 ```

### 1.6. Setup @main struct. 
To work with AppDelegate and ViewModel.

Code:  
```Swift 
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

```

### 1.7. Fill MainContentView().  
To display list of alert messages. 

Code:  
```Swift
//
//  MainContentView.swift
//  SwiftUIandAmazonSNSPush
//
//  Created by Petro Onishchuk on 8/7/22.
//

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var notificationAppVM: NotificationAppVM
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(notificationAppVM.allMessages, id: \.self) {
                        message in
                        VStack(alignment: .leading) {
                            Text("Title: \(message.title)")
                            Text("Info: \(message.description)")
                            Text("Date: \(notificationAppVM.convertDate(date: message.massageDate))")
                        }
                    }
                } header: {
                    Text("Messages List Section")
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(role: .destructive) {
                        notificationAppVM.cleanMessageList()
                    } label: {
                        Text("Clean List")
                    }
                }
            }
            .navigationTitle("Notification from ASNS")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                notificationAppVM.setupNotifications()
            }
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}

```
## 2. Setup Apple Developer Account
### 2.1. In Section: Certificates, Identifiers & Profiles, select Keys. We will be creating a key for work with Push Notification.  
### Tap +.  
 ![SwiftUITutorials006.jpeg](images/SwiftUITutorials006.jpeg)
  
 ### 2.2. Select: Apple Push Notifications service (APNs)  
 Tap: Continue.  
  ![SwiftUITutorials007.jpeg](images/SwiftUITutorials007.jpeg)
    
### 2.3. Tap: Register.
   ![SwiftUITutorials008.jpeg](images/SwiftUITutorials008.jpeg)
     
### 2.4. We have Key ID and then Download Your Key.  
   ![SwiftUITutorials009.jpeg](images/SwiftUITutorials009.jpeg)
   
### 2.5. This our Key: AmazonSNS.  
   ![SwiftUITutorials010.jpeg](images/SwiftUITutorials010.jpeg)
     
### 2.6. In section Membership we have Team ID. 
   ![SwiftUITutorials011.jpeg](images/SwiftUITutorials011.jpeg)
     
## 3. Setup Amazon Amazon Simple Notification Service. 

### 3.1. (Create account, if you don't have)
### 3.2. In All services select Simple Notification Service.  
   ![SwiftUITutorials012.jpeg](images/SwiftUITutorials012.jpeg)
     
### 3.3. Select: Push Notifications.  
   ![SwiftUITutorials013.jpeg](images/SwiftUITutorials013.jpeg)  
   
### 3.4. Select: Create platform application.  
   ![SwiftUITutorials014.jpeg](images/SwiftUITutorials014.jpeg)
     
### 3.5. Fill section with red arrow.
In section: Choose file (Must take file, that downloaded from Apple Developer Account).
File:  
   ![SwiftUITutorials009.jpeg](images/SwiftUITutorials009.jpeg) 
    
### Amazon SNS section for fill:
   ![SwiftUITutorials015.jpeg](images/SwiftUITutorials015.jpeg)
    
### Part 2:  
   ![SwiftUITutorials016.jpeg](images/SwiftUITutorials016.jpeg)
   
### Signing key ID: From Apple Developer Account == Key ID.    
   ![SwiftUITutorials009.jpeg](images/SwiftUITutorials009.jpeg) 
    
### Team ID: From Apple Developer Account.
In section Membership we have Team ID. 
   ![SwiftUITutorials011.jpeg](images/SwiftUITutorials011.jpeg) 
    
### 3.6.  Tap: Create platform application.  
   ![SwiftUITutorials016.jpeg](images/SwiftUITutorials016.jpeg)
    
### 3.7. If all success, Select: Create application endpoint. 
   ![SwiftUITutorials017.jpeg](images/SwiftUITutorials017.jpeg)
    
### 3.8. Need to run our Xcode Project on the Real Device, and after your give permission for Notification, you must see on the Output DEVICE TOKEN:
(if you don't have it after the first time, reload App).  
   ![SwiftUITutorials018.jpeg](images/SwiftUITutorials018.jpeg)
     
### 3.9. Put DEVICE TOKEN Number in the field Device token on Amazon SMS and press "Create application endpoint"
   ![SwiftUITutorials019.jpeg](images/SwiftUITutorials019.jpeg)
     
### 3.10. If all success, Select: Publish message. 
   ![SwiftUITutorials020.jpeg](images/SwiftUITutorials020.jpeg)
     
### 3.11. You can send Default (Identical payload for all delivery protocols) and change only text Alert. I select a Custom payload for each delivery protocol.
   ![SwiftUITutorials021.jpeg](images/SwiftUITutorials021.jpeg)
   
### 3.12. And change the message. And Tap "Publish message" to send our message. 
   ![SwiftUITutorials022.jpeg](images/SwiftUITutorials022.jpeg)
     
### 3.13. If all success, we can send a new message.  
   ![SwiftUITutorials023.jpeg](images/SwiftUITutorials023.jpeg)
    
### 3.14. After sending a couple of messages, I have seen all messages on the screen.  
   ![SwiftUITutorials024.jpeg](images/SwiftUITutorials024.jpeg)

