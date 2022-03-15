//
//  BooksOfAuthor.swift
//  CoreData&SwiftUIPart05
//
//  Created by Petro Onishchuk
//

import SwiftUI

struct BooksOfAuthor: View {
    
    let allBooksOfAuthor: [Book]
    let nameOfAuthor: String
    
    var body: some View {
        List {
            ForEach(0..<allBooksOfAuthor.count, id: \.self) {
                number in
                HStack {
                    Text("#\(number + 1)")
                    VStack(alignment: .leading) {
                        Text("Title: \(allBooksOfAuthor[number].titleOfBook)")
                        Text("Author: \(allBooksOfAuthor[number].nameOfAuthor)")
                        Text("Published: \(allBooksOfAuthor[number].dateOfPublication)")
                    }
                }
            }
        }.navigationTitle(Text("Books of Author: \(nameOfAuthor)"))
    }
}

struct BooksOfAuthor_Previews: PreviewProvider {
    static var previews: some View {
        BooksOfAuthor(allBooksOfAuthor: [], nameOfAuthor: "Test AuthorName")
    }
}
