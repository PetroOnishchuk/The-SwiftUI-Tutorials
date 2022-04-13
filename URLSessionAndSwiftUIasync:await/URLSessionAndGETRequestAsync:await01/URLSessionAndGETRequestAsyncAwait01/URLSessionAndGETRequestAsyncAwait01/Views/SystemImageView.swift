//
//  SystemImageView.swift
//  URLSessionAndGETRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/13/22.
//

import SwiftUI

struct SystemImageView: View {
    var body: some View {
        Image(systemName: "person")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
    }
}

struct SystemImageView_Previews: PreviewProvider {
    static var previews: some View {
        SystemImageView()
    }
}
