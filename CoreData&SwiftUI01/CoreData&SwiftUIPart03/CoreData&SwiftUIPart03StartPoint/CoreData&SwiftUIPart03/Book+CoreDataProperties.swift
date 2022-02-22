//
//  Book+CoreDataProperties.swift
//  CoreData&SwiftUIPart03
//
//  Created by Petro Onishchuk on 2/22/22.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var publicationDate: Date?
    @NSManaged public var title: String?

}

extension Book : Identifiable {

}
