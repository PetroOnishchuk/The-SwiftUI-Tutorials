//
//  GOWebSocketView.swift
//  SwiftUIAndWebSockets01
//
//  Created by Petro Onishchuk on 7/26/22.
//

import SwiftUI

struct GOWebSocketView: View {
    @StateObject var goWebSocketVM = GOWebSocketsVM()
    
    var body: some View {
        List {
            Section {
                TextField("Enter Text Body", text: $goWebSocketVM.messageText)
                TextField("Enter Sender Text", text: $goWebSocketVM.messageSender)
            } header: {
                Text("Text Fields Section")
            }
            Section {
                Button {
                    goWebSocketVM.connect()
                } label: {
                    Text("Connect to WebSocket Server")
                }
                Button {
                    goWebSocketVM.sendMessageToGOWSServer()
                } label: {
                    Text("Send Text to WS Server")
                }.disabled(goWebSocketVM.checkNewMessageFields())
                Button(role: .destructive) {
                    goWebSocketVM.disconnect()
                } label: {
                    Text("Disconnect WS Server Connection")
                }
                Button(role: .destructive) {
                    goWebSocketVM.cleanTextFields()
                } label: {
                    Text("Clean TextFields")
                }
                Button(role: .destructive) {
                    goWebSocketVM.cleanAllMessages()
                } label: {
                    Text("Clean List")
                }
                
            } header: {
                Text("Button Section")
            }
            Section {
                ForEach(goWebSocketVM.allMessages) {
                    message in
                    VStack(alignment: .leading) {
                        Text("ID: \(message.id)")
                        Text("Sender: \(message.sender)")
                        Text("SenderID \(message.senderID)")
                        Text("Body: \(message.body)")
                    }.font(Font.system(size: 12))
                }
            } header: {
                Text("List of Messages")
            }
            
        }.navigationTitle("SwiftUI & GO WS Server")
    }
}

struct GOWebSocketView_Previews: PreviewProvider {
    static var previews: some View {
        GOWebSocketView()
    }
}
