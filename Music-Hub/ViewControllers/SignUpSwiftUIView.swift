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

    @State var firstName : String = "Giannis"
    @State var lastName : String = "Chatziveroglou"
    @State var email : String = "gchatz@mit.edu"
    @State var password : String = "Lil-frog2290??"
    
    @State var transitionActive : Bool = false;
    @ObservedObject var hide = HideToggle()
    


    var body: some View {
        ScrollView(){
            VStack(){
                Spacer()
                    .frame(height: 50)
                
                Group{
                    HStackText(field: "First Name")
                    TextField("", text: $firstName)
                        .padding()
                        .foregroundColor(.white)
                        .background(Constants.textFieldColor)
                        .cornerRadius(5.0)
                        .frame(maxWidth: 350)

                    HStackText(field: "Last Name")
                    TextField("", text: $lastName)
                        .padding()
                        .foregroundColor(.white)
                        .background(Constants.textFieldColor)
                        .cornerRadius(5.0)
                        .frame(maxWidth: 350)
                    
                    HStackText(field: "Email")
                    TextField("", text: $email)
                        .padding()
                        .foregroundColor(.white)
                        .background(Constants.textFieldColor)
                        .cornerRadius(5.0)
                        .frame(maxWidth: 350)
                }
                
                HStackText(field: "Password")
                HStack{
                    if (self.hide.flag){
                     SecureField("", text: $password)
                        .padding()
                        .background(Constants.textFieldColor)
                        .cornerRadius(5.0)
                        .frame(maxWidth: 350)
                        .foregroundColor(.white)
                        .overlay(HideButton(inst:hide), alignment: .trailing)
                    } else {
                        TextField("", text: $password)
                        .padding()
                        .background(Constants.textFieldColor)
                        .cornerRadius(5.0)
                        .frame(maxWidth: 350)
                        .foregroundColor(.white)
                        .overlay(HideButton(inst:hide), alignment: .trailing)

                        
                    }
                }
                
                Button(action: {
                    let res = SignUpUtils.makeNewUser(email: self.email, password: self.password, firstName: self.firstName, lastName: self.lastName)
                    if res != nil{
                        // Display error message
                    } else {
                        self.transitionActive = true;
                    }
                }){
                    NavTextField(field:"SIGN UP")
                }.padding()
                
                NavigationLink(destination: HomeSwiftUIView(), isActive: $transitionActive){
                    Text("")
                }
                
                Spacer()
            }.padding()
        }
        .frame(maxWidth: .infinity)
        .background(Constants.mainColor)
        .edgesIgnoringSafeArea([.top, .bottom])
        .KeyboardResponsive()
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
