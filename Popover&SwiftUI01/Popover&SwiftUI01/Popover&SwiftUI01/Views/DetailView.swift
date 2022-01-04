//
//  DetailView.swift
//  Popover&SwiftUI01
//
//  Created by Petro Onishchuk on 1/4/22.
//

import SwiftUI

struct DetailView: View {
    let projectImage: ProjectImage
    
    var body: some View {
        VStack {
            Image(systemName: projectImage.name)
                .font(.system(size: 45))
            Text("System Name: \(projectImage.name)")
                .padding()
        }.padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(projectImage: ProjectImage(name: "sun.sin"))
    }
}
