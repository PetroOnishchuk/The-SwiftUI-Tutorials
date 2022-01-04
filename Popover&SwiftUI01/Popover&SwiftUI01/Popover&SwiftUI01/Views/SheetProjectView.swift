//
//  SheetProjectView.swift
//  Popover&SwiftUI01
//
//  Created by Petro Onishchuk on 1/4/22.
//

import SwiftUI

struct SheetProjectView: View {
    @EnvironmentObject var projectImageVM: ProjectImageViewModel
    @State private var selectedImageObject: ProjectImage?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(projectImageVM.allImages, id: \.self) { imageObject in
                    Button {
                        selectedImageObject = imageObject
                    } label: {
                        Image(systemName: imageObject.name)
                            .font(.system(size: 35))
                            .padding()
                    }

                }
            }.navigationTitle(Text("Sheet View"))
                .sheet(item: $selectedImageObject, onDismiss: nil) { item in
                    DetailView(projectImage: item)
                }
        }
    }
}

struct SheetProjectView_Previews: PreviewProvider {
    static var previews: some View {
        SheetProjectView()
    }
}
