//
//  MultiplyMacOSPopoverView.swift
//  PopoverMacOS&SwiftUI
//
//  Created by Petro Onishchuk on 1/4/22.
//

import SwiftUI
 

struct MultiplyMacOSPopoverView: View {
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
                        .popover(isPresented: $projectImageVM.allImages[index].showPopover, arrowEdge: .trailing) {
                            DetailView(projectImage: projectImageVM.allImages[index])
                        }
                }
            }
        }.navigationTitle(Text("Popover & SwiftUI"))
    }
}

struct MultiplyMacOSPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        MultiplyMacOSPopoverView()
    }
}
