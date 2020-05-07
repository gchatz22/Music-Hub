//
//  ContentView.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/16/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct HomeSwiftUIView: View {
    
    var body: some View {
        VStack{
            Spacer()
            Text("You are in the homepage").foregroundColor(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Constants.mainColor)
        .edgesIgnoringSafeArea([.top, .bottom])
        .navigationBarBackButtonHidden(true)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSwiftUIView()
    }
}
