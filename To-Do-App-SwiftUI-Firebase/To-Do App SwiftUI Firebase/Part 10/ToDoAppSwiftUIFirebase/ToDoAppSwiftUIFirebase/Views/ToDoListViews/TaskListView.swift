//
//  TaskListView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 2/15/23.
//

import SwiftUI


struct TaskListView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    
    var body: some View {
        Section {
            ForEach(myAppVM.allTasks, id: \.id) { task in
                NavigationLink(value: task) {
                    TaskCell(task: task)
                    
                }
            }
            .onDelete(perform: deleteTask(at:))
        } header: {
            Text("List of the Tasks")
        }
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

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
