//
//  User.swift
//  ConfirmationDialog&SwiftUI01
//
//  Created by Petro Onishchuk on 12/18/21.
//

import SwiftUI

struct User: Hashable, Identifiable {
    var id: UUID
    var name: String
    var symbol: String
}
