//
//  MainMacOSContentView.swift
//  PopoverMacOS&SwiftUI
//
//  Created by Petro Onishchuk on 1/4/22.
//

import SwiftUI

struct MainMacOSContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Multiply Popover") {
                    MultiplyMacOSPopoverView()
                }
            }
        }
    }
}

struct MainMacOSContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMacOSContentView()
    }
}
