//
//  Book+CoreDataClass.swift
//  CoreData&SwiftUIPart03
//
//  Created by Petro Onishchuk on 2/22/22.
//
//

import Foundation
import CoreData

@objc(Book)
public class Book: NSManagedObject {
    
    var nsNameOfAuthor: String {
        return author ?? "Unknown Author"
    }
    
    var nsTitleOfBook: String {
        return title ?? "Unknown Title"
    }
    
    var nsDateOfPublication: String {
        
        guard let pubDate = publicationDate else { return "Unknown Date of Publication"}
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let dateText = dateFormatter.string(from: pubDate)
        return dateText
    }

}
