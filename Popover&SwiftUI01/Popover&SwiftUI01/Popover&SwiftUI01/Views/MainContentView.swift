//
//  MainContentView.swift
//  Popover&SwiftUI01
//
//  Created by Petro Onishchuk on 1/4/22.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Single Popover") {
                   SinglePopoverView()
                }
                NavigationLink("Multiple Popovers") {
                   MultiplyPopoverView()
                }
                NavigationLink("Sheet") {
                    SheetProjectView()
                }
                
            }.navigationTitle(Text("Popover & SwiftUI"))
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
