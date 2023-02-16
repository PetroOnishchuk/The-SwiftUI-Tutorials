//
//  ToDoListView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 1/7/23.
//

import SwiftUI

struct ToDoListView: View {
    var body: some View {
        Form {
            AddNewTaskView()
            
            TaskListView()
            
        }
        .toolbar(content: {
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
