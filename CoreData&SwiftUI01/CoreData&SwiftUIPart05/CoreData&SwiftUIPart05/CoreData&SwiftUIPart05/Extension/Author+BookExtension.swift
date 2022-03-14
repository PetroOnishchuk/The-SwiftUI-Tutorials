//
//  Author+BookExtension.swift
//  CoreData&SwiftUIPart05
//
//  Created by Petro Onishchuk
//

import Foundation
import SwiftUI

extension Book {
    
    var titleOfBook: String {
        return title ?? "Unknown title"
    }
    
    var nameOfAuthor: String {
        return author?.name ?? "Unknown Author"
    }
    
    var dateOfPublication: String {
        guard let pubDate = publicationDate else {
            return "Unknown Date"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let dateText = dateFormatter.string(from: pubDate)
        
        return dateText
    }
}

extension Author {
    
    var nameOfAuthor: String {
        return name ?? "Unknown author name"
    }
    
    var allBooks: [Book] {
        if let list = books as? Set<Book> {
            return list.sorted(by: {$0.titleOfBook > $1.titleOfBook})
        } else {
            return []
        }
    }
}
