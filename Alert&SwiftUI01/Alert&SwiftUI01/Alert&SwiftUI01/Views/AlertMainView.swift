//
//  AlertMainView.swift
//  Alert&SwiftUI01
//
//  Created by Petro Onishchuk on 12/14/21.
//

import SwiftUI

struct AlertMainView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("New Alert View") {
                    NewAlertView()
                }
                NavigationLink("Old Alert View") {
                   OldAlertView()
                }
            }.navigationTitle(Text("Alert & SwiftUI"))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AlertMainView_Previews: PreviewProvider {
    static var previews: some View {
        AlertMainView()
    }
}
