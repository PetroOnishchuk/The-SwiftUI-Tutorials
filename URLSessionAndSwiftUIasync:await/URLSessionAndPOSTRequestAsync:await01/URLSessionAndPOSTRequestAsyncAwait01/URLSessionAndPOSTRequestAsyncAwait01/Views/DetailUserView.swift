//
//  DetailUserView.swift
//  URLSessionAndPOSTRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/16/22.
//

import SwiftUI

struct DetailUserView: View {
    @EnvironmentObject var postAppVM: PostRequestViewModel
    
    var body: some View {
        Section {
            Text("Name: \(postAppVM.mainUser.name.capitalized)")
            Text("Job: \(postAppVM.mainUser.job)")
            Text("ID: \(postAppVM.mainUser.id)")
            Text("Created Date: \(postAppVM.mainUser.modifiedDateCreated)")
        } header: {
            Text("Users Data Section")
        }
    }
}

struct DetailUserView_Previews: PreviewProvider {
    static var previews: some View {
        DetailUserView()
            .environmentObject(PostRequestViewModel())
    }
}
