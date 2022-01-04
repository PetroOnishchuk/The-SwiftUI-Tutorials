//
//  MultiplyPopoverView.swift
//  Popover&SwiftUI01
//
//  Created by Petro Onishchuk on 1/4/22.
//

import SwiftUI

struct MultiplyPopoverView: View {
    @EnvironmentObject var projectImageVM: ProjectImageViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<projectImageVM.allImages.count, id: \.self) { index in 
                    Image(systemName: projectImageVM.allImages[index].name)
                        .font(.system(size: 40))
                        .padding()
                        .onTapGesture {
                            projectImageVM.allImages[index].showPopover = true
                        }
                        .popover(isPresented: $projectImageVM.allImages[index].showPopover, attachmentAnchor: .point(UnitPoint(x: 0.5, y: 0))
                        //         arrowEdge:
                        ) {
                            DetailView(projectImage: projectImageVM.allImages[index])
                        }
                }
            }
        }.navigationTitle(Text("Multiple Popovers View"))
    }
}

struct MultiplyPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        MultiplyPopoverView()
    }
}
