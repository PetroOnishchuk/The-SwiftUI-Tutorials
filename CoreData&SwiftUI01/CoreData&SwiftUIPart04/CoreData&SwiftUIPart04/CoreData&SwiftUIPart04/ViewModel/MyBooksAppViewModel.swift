//
//  MyBooksAppViewModel.swift
//  CoreData&SwiftUIPart04
//
//  Created by Petro Onishchuk
//

import Foundation
import SwiftUI

class MyBooksAppViewModel: ObservableObject {
    
    @Published var textForPredicate = ""
    @Published var selectedDescriptors: DescriptorsCollections = .title
    @Published var predicateDate = Date()
    
    func takeNameDescriptors(selected: DescriptorsCollections) -> String {
        switch selected {
        case .title:
            return "Title"
        case .author:
            return "Author"
        case .publicationDate:
            return "Published"
        case .empty:
            return   "N/A"
        }
    }
    
    
    
}


enum DescriptorsCollections: String, CaseIterable {
    case title
    case author
    case publicationDate
    case empty = ""
}
