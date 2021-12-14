//
//  User.swift
//  Alert&SwiftUI01
//
//  Created by Petro Onishchuk on 12/14/21.
//

import SwiftUI


struct User: Hashable, Identifiable {
    var id: UUID
    var name: String
    var symbol: String
}
