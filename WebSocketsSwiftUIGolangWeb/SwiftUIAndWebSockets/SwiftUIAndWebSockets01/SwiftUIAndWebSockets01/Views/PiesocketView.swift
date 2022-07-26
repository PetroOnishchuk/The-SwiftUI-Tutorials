//
//  PiesocketView.swift
//  SwiftUIAndWebSockets01
//
//  Created by Petro Onishchuk on 7/25/22.
//

import SwiftUI

struct PiesocketView: View {
    @State var text = ""
    @StateObject var piesocketVM = PiesocketVM()
    
    var body: some View {
        List {
            Section {
                TextField("Enter Text", text: $text)
            }header: {
                Text("Text Field Section")
            }
            Section {
                Button {
                    piesocketVM.connect()
                } label: {
                    Text("Connect to WS Server")
                }
                Button {
                    piesocketVM.send(text: text)
                } label: {
                    Text("Send Message to WS Server")
                }
                Button(role: .destructive) {
                    piesocketVM.disconnect()
                } label: {
                    Text("Disconnect from WS Server")
                }
                Button(role: .destructive) {
                    piesocketVM.cleanAllMessages()
                } label: {
                    Text("Clean List")
                }
            } header: {
                Text("Button Section")
            }
            Section {
                ForEach(piesocketVM.allMessages) {
                    message in
                    VStack(alignment: .leading) {
                        Text("ID: \(message.id)")
                        Text("Sender: \(message.sender)")
                        Text("SenderID: \(message.senderID)")
                        Text("Body: \(message.body)")
                    }.font(Font.system(size: 12))
                }
            } header: {
                Text("List of All Messages")
            }
            
        }.navigationTitle("Piesocket & WebSockets")
    }
}

struct PiesocketView_Previews: PreviewProvider {
    static var previews: some View {
        PiesocketView()
    }
}
