//
//  BookExtension.swift
//  CoreData&SwiftUIPart04
//
//  Created by Petro Onishchuk on 3/5/22.
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
