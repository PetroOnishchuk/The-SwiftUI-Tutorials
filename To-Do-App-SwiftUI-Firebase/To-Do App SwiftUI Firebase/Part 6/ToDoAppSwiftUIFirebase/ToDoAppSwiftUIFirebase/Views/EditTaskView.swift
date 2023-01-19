//
//  EditTaskView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 1/13/23.
//

import SwiftUI

struct EditTaskView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    @Environment(\.dismiss) var dismiss
    @State var taskText = ""
    var task: Task?
    
    var body: some View {
        List {
            Section {
                TextField("Task Text", text: $taskText)
            } header: {
                Text("Task Text Section")
            }
            Section {
                Button {
                    if let task {
                        let newTask = Task(id: task.id, text: taskText, dateCreated: task.dateCreated, isCompleted: task.isCompleted)
                        myAppVM.updateTaskText(updateTask: newTask)
                    }
                } label: {
                    Text("Update Text")
                }.disabled(taskText.isEmpty)
            } header: {
                Text("Button Section")
            }
        }.toolbar(content: {
            Button("Dismiss") {
                dismiss()
            }
        })
        .navigationTitle("Update Task")
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView()
    }
}
