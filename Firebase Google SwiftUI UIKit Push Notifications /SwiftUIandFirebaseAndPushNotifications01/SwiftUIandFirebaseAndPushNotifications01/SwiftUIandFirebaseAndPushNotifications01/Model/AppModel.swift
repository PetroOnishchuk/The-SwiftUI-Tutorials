//
//  AppModel.swift
//  SwiftUIandFirebaseAndPushNotifications01
//
//  Created by Petro Onishchuk on 8/25/22.
//

import Foundation
import SwiftUI


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



