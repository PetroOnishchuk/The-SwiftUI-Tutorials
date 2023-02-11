//
//  TextFieldV01.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 2/9/23.
//

import SwiftUI

struct TextFieldV01: View {
    @Binding var taskText: String
    
    var body: some View {
        ZStack {
            TextEditor(text: $taskText)
            Text(taskText).opacity(0).padding(.all, 8)
                .lineLimit(5)
        }
    }
}

struct TextFieldV01_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldV01(taskText: .constant(""))
    }
}
