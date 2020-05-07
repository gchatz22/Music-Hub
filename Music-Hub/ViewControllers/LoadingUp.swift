//
//  LoadingUp.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 5/5/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct LoadingUp: View {
    var body: some View {
        VStack{
            Text("Hello, World!")
        }
        .frame(maxWidth: .infinity)
        .background(Constants.mainColor)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct LoadingUp_Previews: PreviewProvider {
    static var previews: some View {
        LoadingUp()
    }
}
