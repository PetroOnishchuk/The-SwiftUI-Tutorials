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
