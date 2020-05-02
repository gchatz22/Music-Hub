//
//  SignUpSwiftUIView.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/30/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//=

import UIKit
import SwiftUI

struct SignUpSwiftUIView: View {

    @State var email : String = ""
    @State var password : String = ""
    @ObservedObject var hide = HideToggle()


    var body: some View {
        VStack{
            
            Spacer()
            .frame(height: 100)
            
            HStackText(field: "Email")
            TextField("Email", text: $email)
                .padding()
                .foregroundColor(.white)
                .background(Constants.textFieldColor)
                .cornerRadius(5.0)
                .frame(maxWidth: 350)
            
            HStackText(field: "Password")
            HStack{
                if (self.hide.flag){
                 SecureField("Pasword", text: $password)
                    .padding()
                    .background(Constants.textFieldColor)
                    .cornerRadius(5.0)
                    .frame(maxWidth: 350)
                    .foregroundColor(.white)
                    .overlay(HideButton(inst:hide), alignment: .trailing)
                } else {
                    TextField("Pasword", text: $password)
                    .padding()
                    .background(Constants.textFieldColor)
                    .cornerRadius(5.0)
                    .frame(maxWidth: 350)
                    .foregroundColor(.white)
                    .overlay(HideButton(inst:hide), alignment: .trailing)
                }
            }
            
            NavigationLink(destination: HomeSwiftUIView()){
                NavTextField(field:"SIGN UP")
            }
            .navigationBarTitle("")
            .padding()
            .foregroundColor(.white)
            
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Constants.mainColor)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

class HideToggle:ObservableObject{
    @Published var flag:Bool = true
}

struct HideButton: View {
    
    var inst:HideToggle
    
    var body: some View {
        Button(action: {
            self.inst.flag.toggle()
        }){
            Image(systemName: self.inst.flag ? "eye.fill": "eye.slash.fill")
                .foregroundColor(.white)
                .offset(x: -10, y: 0)
        }
    }
}

struct HStackText: View {
    
    var field: String
    
    var body: some View {
        HStack{
            Spacer().frame(maxWidth: 30)
            Text(field)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.top, 20)
            Spacer()
        }
    }
}

struct SignUpSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpSwiftUIView().previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
    }
}
