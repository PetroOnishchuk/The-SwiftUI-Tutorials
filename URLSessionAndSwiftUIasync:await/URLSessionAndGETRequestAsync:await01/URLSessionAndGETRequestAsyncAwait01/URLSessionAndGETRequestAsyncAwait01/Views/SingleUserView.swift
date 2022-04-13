//
//  SingleUserView.swift
//  URLSessionAndGETRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/13/22.
//

import SwiftUI

struct SingleUserView: View {
    let user: User
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("First Name: \(user.firstName)")
                Text("Last Name: \(user.lastName)")
                Text("ID: \(user.id)")
            }
            Spacer()
            AsyncImage(url: URL(string: user.avatar)) {
                imagePhase in
                switch imagePhase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                case .empty:
                    SystemImageView()
                case .failure(_):
                    SystemImageView()
                @unknown default:
                    SystemImageView()
                }
            }
        }
    }
}

struct SingleUserView_Previews: PreviewProvider {
    static let user = User(id: 10, email: "test@email.com", firstName: "Test First Name", lastName: "Test Last Name", avatar: "https://reqres.in/img/faces/7-image.jpg")
    static var previews: some View {
        SingleUserView(user: user)
    }
}
