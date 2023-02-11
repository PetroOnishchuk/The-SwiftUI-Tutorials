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
                TextFieldV02(taskText: $taskText)
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
                    NavigationLink(value: task) { 
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.seal.fill" : "checkmark.seal")
                                .font(Font.title2)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    myAppVM.updateTasksStatus(selectedTask: task)
                                }
                            VStack(alignment: .leading) {
                                 
                                Text("\(task.text)")
                                    .lineLimit(2)
                                
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("D/C: \(task.dateCreated, formatter: myAppVM.formatDate)")
                                UpdateDateView(inputDate: task.lastUpdated)
                            }.font(Font.system(size: 10))
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                .onDelete(perform: deleteTask(at:))
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
    
    // MARK: PART #6
    // delete task
    func deleteTask(at offsets: IndexSet) {
        let selectedTask = offsets.map { index in
            self.myAppVM.allTasks[index]
        }
        
        if selectedTask.count == 1 {
            myAppVM.deleteUsersTask(selectedTask: selectedTask[0])
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
