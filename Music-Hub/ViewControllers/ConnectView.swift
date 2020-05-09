//
//  Connect.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 5/7/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct ConnectView: View {
    
    var users: [String] = ["Giannis", "Sofia", "Mpampas", "Mama"]
    
    
    var body: some View {
        
//        NavigationView{
//            List (users, id:\.self) {item in
//                Text(item)
//            }
//            .padding()
//            .navigationBarTitle(Text("Connect"))
//        }
//        .padding()
//        .frame(maxWidth: .infinity)
//        .edgesIgnoringSafeArea([.top, .bottom])
        
        VStack{
            Spacer()
            Text("Connect View")
                .foregroundColor(.white)
            Spacer()
        }
        .navigationBarTitle(Text("Connect"))
        .frame(maxWidth: .infinity)
        .background(Constants.mainColor)
        .edgesIgnoringSafeArea([.top, .bottom])
        
        
    }
}

struct Connect_Previews: PreviewProvider {
    static var previews: some View {
        ConnectView()
    }
}
