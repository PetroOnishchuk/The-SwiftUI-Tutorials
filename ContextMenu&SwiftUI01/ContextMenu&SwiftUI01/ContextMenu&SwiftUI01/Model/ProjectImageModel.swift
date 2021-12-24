//
//  ProjectImageModel.swift
//  ContextMenu&SwiftUI01
//
//  Created by Petro Onishchuk on 12/24/21.
//

import SwiftUI


struct ProjectImage: Identifiable, Hashable {
    var id: UUID
    var name: String
    var color: Color
    
    init(id: UUID = UUID(), name: String, color: Color = Color.gray) {
        self.id = id
        self.name = name
        self.color = color
    }
}
