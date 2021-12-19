//
//  MainConfirmationDialogView.swift
//  ConfirmationDialog&SwiftUI01
//
//  Created by Petro Onishchuk on 12/18/21.
//

import SwiftUI

struct MainConfirmationDialogView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Confirmation Dialog") {
                   ConfirmationDialogView()
                }
                NavigationLink("Action Sheet") {
                    OldActionSheetView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("Confirmation Dialog & SwiftUI"))
        }
    }
}

struct MainConfirmationDialogView_Previews: PreviewProvider {
    static var previews: some View {
        MainConfirmationDialogView()
    }
}
