//
//  ToDoListView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 1/7/23.
//

import SwiftUI

struct ToDoListView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    @State private var taskText = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Task text", text: $taskText)
                Button {
                    myAppVM.addNewTask(taskText: taskText)
                    taskText = ""
                } label: {
                    Text("Add a new Task")
                }
            } header: {
                Text("Add a new Task")
            }
            
            Section {
                ForEach(myAppVM.allTasks, id: \.id) { task in
                    HStack {
                        Image(systemName: task.isCompleted ? "checkmark.seal.fill" : "checkmark.seal")
                            .font(Font.title2)
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("ID: \(task.id)")
                            Text("Text: \(task.text)")
                            Text("Date created: \(task.dateCreated, formatter: myAppVM.formatDate)")
                            UpdateDateView(inputDate: task.lastUpdated)
                        }
                    }
                }
            } header: {
                Text("List of the Tasks")
            }
            
        }.toolbar(content: {
            ToolbarItem() {
                NavigationLink(value: "setting") {
                    Image(systemName: "gear")
                }
            }
        })
        .navigationTitle("To-Do List")
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
