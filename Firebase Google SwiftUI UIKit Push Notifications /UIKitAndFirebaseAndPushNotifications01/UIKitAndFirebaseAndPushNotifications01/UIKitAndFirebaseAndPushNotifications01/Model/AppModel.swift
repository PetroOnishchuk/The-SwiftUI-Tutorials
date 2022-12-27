//
//  AppModel.swift
//  UIKitAndFirebaseAndPushNotifications01
//
//  Created by Petro Onishchuk on 8/27/22.
//

import Foundation
import UIKit

struct Message: Identifiable, Hashable {
    var id: UUID
    var title: String
    var body: String
    var messagesDate: Date
}


enum NotificationNameValue: String {
    case firebasePushNotification
    case FCMTTokenNotifications
}

enum CustomCellReuseIdentifier: String {
    case messagesCell
}
