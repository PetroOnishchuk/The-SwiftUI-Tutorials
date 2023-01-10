//
//  SelectedContentView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 12/23/22.
//

import SwiftUI

struct SelectedContentView: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    
    var body: some View {
        if myAppVM.userSignedIn {
            ToDoListView()
        } else {
           MainLoginView()
        }
    }
}

struct SelectedContentView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedContentView()
    }
}
