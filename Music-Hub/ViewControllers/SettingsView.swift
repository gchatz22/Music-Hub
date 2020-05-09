//
//  Settings.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 5/7/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @State var logout: Bool = false
    
    var body: some View {
        VStack{
            Spacer()
            Button(action: {
                Database.logout()
                AppState.logout()
            }){
                Text("Logout")
            }.padding()
            Spacer()
        }
        .navigationBarTitle(Text("Settings"))
        .frame(maxWidth: .infinity)
        .background(Constants.mainColor)
        .edgesIgnoringSafeArea([.top, .bottom])
        .navigationBarTitle(Text("Settings"))
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
