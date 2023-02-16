//
//  AddNewTaskView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 2/15/23.
//

import SwiftUI

struct AddNewTaskView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    @State private var taskText = ""
    
    var body: some View {
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
    }
}

struct AddNewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskView()
    }
}
