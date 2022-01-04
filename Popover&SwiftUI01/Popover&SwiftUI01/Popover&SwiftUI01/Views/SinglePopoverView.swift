//
//  SinglePopoverView.swift
//  Popover&SwiftUI01
//
//  Created by Petro Onishchuk on 1/4/22.
//

import SwiftUI

struct SinglePopoverView: View {
    @State var showPopover = false
    @State var popoverItem: ProjectImage?
    
    
    var body: some View {
        VStack {
            Image(systemName: "sun.min")
                .font(.system(size: 45))
                .padding()
                .onTapGesture {
                   showPopover = true
                  //  popoverItem = ProjectImage(name: "sun.min")
                }
        }
        .popover(isPresented: $showPopover, content: {
            VStack {
                Image(systemName: "sun.min")
                    .font(.system(size: 45))

                Text("System Name: sun.min")
                    .padding()
            }.padding()
        })
//            .popover(item: $popoverItem, content: { imageObject in
//                VStack {
//                    Image(systemName: imageObject.name)
//                        .font(.system(size: 45))
//
//                    Text("System Name: \(imageObject.name)")
//                        .padding()
//                }.padding()
//            })
        .navigationTitle(Text("Single Popover View"))
    }
}

struct SinglePopoverView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePopoverView()
    }
}
