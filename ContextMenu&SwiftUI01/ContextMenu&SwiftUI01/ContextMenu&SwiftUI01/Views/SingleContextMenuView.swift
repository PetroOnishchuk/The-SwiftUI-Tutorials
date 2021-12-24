//
//  SingleContextMenuView.swift
//  ContextMenu&SwiftUI01
//
//  Created by Petro Onishchuk on 12/24/21.
//

import SwiftUI

struct SingleContextMenuView: View {
    @State private var customColor: Color = Color.gray
    
    var body: some View {
        VStack {
            Image(systemName: "homepodmini.fill")
                .foregroundColor(customColor)
                .font(.system(size: 55))
                .padding()
                .contextMenu {
                    VStack {
                        Text("Select Color")
                        Button("Yellow HomePod mini") {
                            withAnimation(.linear(duration: 3.0)) {
                                customColor = .yellow
                            }
                        }
                        Button("Blue HomePod mini") {
                            withAnimation(.linear(duration: 3.0)) {
                                customColor = .blue
                            }
                        }
                        Button("Green HomePod mini") {
                            withAnimation(.linear(duration: 3.0)) {
                                customColor = .green
                            }
                        }
                        Button("Gray HomePod mini") {
                            withAnimation(.linear(duration: 3.0)) {
                                customColor = .gray
                            }
                        }
                        Button("Orange HomePod mini") {
                            withAnimation(.linear(duration: 3.0)) {
                                customColor = .orange
                            }
                        }
                    }
                }
        }.navigationTitle(Text("Single Context Menu"))
    }
}

struct SingleContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SingleContextMenuView()
    }
}
