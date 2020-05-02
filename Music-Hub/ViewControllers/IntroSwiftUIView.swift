//
//  IntroSwiftUIView.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/30/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct IntroSwiftUIView: View {
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                
                NavigationLink(destination: SignUpSwiftUIView()){
                    NavTextField(field:"SIGN UP")
                }
                .navigationBarTitle("")
                .padding()
            
                NavigationLink(destination: LoginSwiftUIView()){
                    NavTextField(field:"LOG IN")
                }
                
                Spacer()
                    .frame(height: 100)
                
            }
            .frame(maxWidth: .infinity)
            .background(Constants.mainColor)
            .edgesIgnoringSafeArea([.top, .bottom])
        }
        .accentColor(.white)
    }
}


struct NavTextField: View {
    var field:String
    var body: some View {
        Text(field)
            .font(.headline)
            .fontWeight(.medium)
            .padding()
            .frame(maxWidth: 300)
            .background(Constants.buttonColor)
            .cornerRadius(25.0)
    }
}


#if DEBUG
struct IntroSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        IntroSwiftUIView().previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
    }
}
#endif

