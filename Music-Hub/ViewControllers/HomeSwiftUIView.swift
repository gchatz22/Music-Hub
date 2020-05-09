//
//  ContentView.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/16/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct HomeSwiftUIView: View {
    
    @State var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            ConnectView()
                .tabItem {
                    Image(systemName: "heart.fill")
//                    Text("Connect")
            }.tag(1)
            
            PartyView()
                .tabItem {
                    Image(systemName: "list.dash")
//                    Text("Party")
                }.tag(2)

            SettingsView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
//                    Text("Settings")
                }.tag(3)
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSwiftUIView()
    }
}
