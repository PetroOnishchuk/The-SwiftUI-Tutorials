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
            Text("U/D: \(updateDate, formatter: myAppVM.formatDate)")
        } else {
            Text("")
        }
    }
}

struct UpdateDateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDateView(inputDate: Date())
    }
}
