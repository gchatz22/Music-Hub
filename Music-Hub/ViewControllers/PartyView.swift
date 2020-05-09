//
//  Party.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 5/7/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct PartyView: View {
    var body: some View {
        
        VStack{
            Spacer()
            Text("Party View")
                .foregroundColor(.white)
            Spacer()
        }
        .navigationBarTitle(Text("Party"))
        .frame(maxWidth: .infinity)
        .background(Constants.mainColor)
        .edgesIgnoringSafeArea([.top, .bottom])
        
        
    }
}

struct Party_Previews: PreviewProvider {
    static var previews: some View {
        PartyView()
    }
}
