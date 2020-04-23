//
//  ContentView.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/16/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    let playURI = "spotify:track:2xLMifQCjDGFmkHkpNLD9h"

    var appRemote: SPTAppRemote? {
        get {
            return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.appRemote
        }
    }
    
    var body: some View {
        VStack {
            Button(action: {
//                if self.appRemote?.isConnected == true {
////                    self.appRemote?.connect()
//                    self.appRemote?.authorizeAndPlayURI(self.playURI)
//                } else {
//                    print("App remote is not connected")
//                }


            }){
                Text("Connect to your Spotify account")
                    .font(.title)
                .multilineTextAlignment(.center)

            }
            .accentColor(.white)
            .padding()
            .background(Color(red: 30/255, green: 215/255, blue: 96/255, opacity: 1.0))
            .cornerRadius(20)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 25/255, green: 20/255, blue: 20/255, opacity: 1.0))
        .edgesIgnoringSafeArea(.all)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
