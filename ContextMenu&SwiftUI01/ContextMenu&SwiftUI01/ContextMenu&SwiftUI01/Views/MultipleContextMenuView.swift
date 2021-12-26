//
//  MultipleContextMenuView.swift
//  ContextMenu&SwiftUI01
//
//  Created by Petro Onishchuk on 12/24/21.
//

import SwiftUI

struct MultipleContextMenuView: View {
    @EnvironmentObject var projectImageVM: ProjectImageViewModel
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(projectImageVM.allImages, id:\.self){ image in
                    Image(systemName: image.name)
                        .font(.system(size: 35))
                        .foregroundColor(image.color)
                        .padding()
                        .contextMenu {
                            VStack {
                                Text("Select Color")
                                Button("Set Yellow Color") {
                                    projectImageVM.setColor(.yellow, for: image)
                                }
                                Button("Set Blue Color") {
                                    projectImageVM.setColor(.blue, for: image)
                                }
                                Button("Set Red Color") {
                                    projectImageVM.setColor(.red, for: image)
                                }
                                Button("Set Green Color") {
                                    projectImageVM.setColor(.green, for: image)
                                }
                                Button("Set Orange Color") {
                                    projectImageVM.setColor(.orange, for: image)
                                }
                            }
                        }
                }
            }.navigationTitle(Text("Multiply Context Menu"))
        }
    }
}

struct MultipleContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleContextMenuView()
    }
}
