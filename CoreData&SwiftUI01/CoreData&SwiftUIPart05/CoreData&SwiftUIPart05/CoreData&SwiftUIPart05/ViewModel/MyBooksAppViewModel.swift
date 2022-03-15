//
//  MyBooksAppViewModel.swift
//  CoreData&SwiftUIPart05
//
//  Created by Petro Onishchuk
//

import Foundation
import SwiftUI

class MyBooksAppViewModel: ObservableObject {
    
    @Published var bookTitle = ""
    @Published var bookDate = Date()
    @Published var authorOfBook = ""
    @Published var selectedAuthor: Author? = nil
    
    func cleanBookFields() {
        
        bookTitle = ""
        bookDate = Date()
        authorOfBook = ""
        
    }
    
    func cleanAuthorFields() {
        
        authorOfBook = ""
    }
}
