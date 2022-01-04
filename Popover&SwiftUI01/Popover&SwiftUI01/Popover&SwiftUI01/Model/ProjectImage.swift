//
//  ProjectImage.swift
//  Popover&SwiftUI01
//
//  Created by Petro Onishchuk on 1/4/22.
//

import SwiftUI

struct ProjectImage: Hashable, Identifiable {
    var id: UUID
    var name: String
    var showPopover: Bool
    
    init(id: UUID = UUID(), name: String, showPopover: Bool = false) {
        self.id = id
        self.name = name
        self.showPopover = showPopover
    }
}
