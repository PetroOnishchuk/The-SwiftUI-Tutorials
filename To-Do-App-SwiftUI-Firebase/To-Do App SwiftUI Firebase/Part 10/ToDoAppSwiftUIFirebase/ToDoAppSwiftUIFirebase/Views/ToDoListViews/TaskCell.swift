//
//  TaskCell.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 2/15/23.
//

import SwiftUI
import FirebaseRemoteConfig
import FirebaseRemoteConfigSwift
import Firebase


struct TaskCell: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    @RemoteConfigProperty(key: "checkmark", fallback: "checkmark.seal") var checkmark: String
    @RemoteConfigProperty(key: "checkmarkFill", fallback: "checkmark.seal.fill") var checkmarkFill: String
    
    var task: Task
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? checkmarkFill : checkmark)
                .frame(height: 25)
            
                .foregroundColor(Color.blue)
                .onTapGesture {
                    myAppVM.updateTasksStatus(selectedTask: task)
                }
            // Alignment Guide
                .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                    
                    // 2
                    return 0
                }
            VStack(alignment: .leading, spacing: 0) {
                
                Text("\(task.text)")
                    .font(.system(size: 14))
                    .lineLimit(3)
                
            }.padding(0)
            
            
            Spacer()
            VStack(alignment: .trailing) {
                Text("D/C: \(task.dateCreated, formatter: myAppVM.formatDate)")
                UpdateDateView(inputDate: task.lastUpdated)
            }.font(Font.system(size: 10))
                .foregroundColor(Color.gray)
        }.frame(height: 40)
    }
}

//struct TaskCell_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskCell()
//    }
//}
