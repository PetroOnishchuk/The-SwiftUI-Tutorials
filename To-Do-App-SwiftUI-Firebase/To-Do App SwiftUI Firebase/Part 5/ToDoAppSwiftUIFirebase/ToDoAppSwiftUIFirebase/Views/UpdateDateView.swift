//
//  UpdateDateView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 1/7/23.
//

import SwiftUI

struct UpdateDateView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    
    let inputDate: Date?
    
    var body: some View {
        if let updateDate = inputDate {
            Text("Update Date \(updateDate, formatter: myAppVM.formatDate)")
        } else {
            Text("You don't update this Task yet.")
        }
    }
}

struct UpdateDateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDateView(inputDate: Date())
    }
}
