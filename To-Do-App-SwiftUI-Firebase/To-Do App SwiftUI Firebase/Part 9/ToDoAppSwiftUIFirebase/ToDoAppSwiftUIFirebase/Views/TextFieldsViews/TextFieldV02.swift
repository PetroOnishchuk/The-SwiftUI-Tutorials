//
//  TextFieldV02.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 2/9/23.
//

import SwiftUI

struct TextFieldV02: View {
    @Binding var taskText: String
    var body: some View {
             TextField("Task Text", text: $taskText, axis: .vertical)
                        .lineLimit(5)
    }
}

struct TextFieldV02_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldV02(taskText: .constant(""))
    }
}
