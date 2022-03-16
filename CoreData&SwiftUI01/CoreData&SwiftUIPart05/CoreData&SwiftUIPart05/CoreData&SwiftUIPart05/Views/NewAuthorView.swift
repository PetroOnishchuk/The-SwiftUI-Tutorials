//
//  NewAuthorView.swift
//  CoreData&SwiftUIPart05
//
//  Created by Petro Onishchuk

import SwiftUI

struct NewAuthorView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var myBooksVM: MyBooksAppViewModel
    
    var body: some View {
        List {
            TextField("Author Name", text: $myBooksVM.authorOfBook)
                .padding(.bottom, 10)
            Button("Create a New Author") {
                let newAuthor = Author(context: viewContext)
                newAuthor.name = myBooksVM.authorOfBook
                
                do {
                    try viewContext.save()
                    myBooksVM.cleanBookFields()
                    presentation.wrappedValue.dismiss()
                } catch {
                    print("Error Description \(error.localizedDescription)")
                }
            }
        }.navigationTitle(Text("Create a New Author"))
    }
}

struct NewAuthorView_Previews: PreviewProvider {
    static var previews: some View {
        NewAuthorView()
    }
}
