//
//  BookExtension.swift
//  CoreData&SwiftUIPart04StartPoint
//
//  Created by Petro Onishchuk  
//

import Foundation

extension Book {
    
    var nameOfAuthor: String {
        return author ?? "Unknown Author"
    }
    
    var titleOfBook: String {
        return title ?? "Unknown Title"
    }
    
    var dateOfPublication: String {
        guard let pubDate = publicationDate else { return "Unknown Date"}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let dateText = dateFormatter.string(from: pubDate)
        return dateText
    }
}
