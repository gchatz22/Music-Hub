//
//  Settings.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 5/7/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var user: User = User.shared
    
    var body: some View {
        VStack{
            Spacer()
            Button(action: {
                Database.logout()
            }){
                Text("Logout")
            }.padding()
            
            if (user.streamingConnected == false) {
                Button(action: {
                    AppState.initiateSPTSession()
                }){
                    Text("Connect Spotify")
                }.padding()
            }
            
            Button(action: {
                Controller.shared.playSong()
            }){
                Text("Play Song")
            }.padding()
            
            Spacer()
        }
        .navigationBarTitle(Text("Settings"))
        .frame(maxWidth: .infinity)
        .background(Constants.mainColor)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
