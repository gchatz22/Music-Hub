//
//  LoginSwiftUIView.swift
//  
//
//  Created by Giannis Chatziveroglou on 4/30/20.
//

import SwiftUI

struct LoginSwiftUIView: View {
    
    @State var email : String = "gchatz@mit.edu"
    @State var password : String = "Lil-frog2290??"
    
    @ObservedObject var utils: AuthUtils = AuthUtils()
    @ObservedObject var hide: HideToggle = HideToggle()
    
    var body: some View {
        ScrollView(){
            VStack(){
                
                Spacer()
                    .frame(height: 50)
                
                HStackText(field: "Email")
                TextField("", text: $email)
                    .padding()
                    .foregroundColor(.white)
                    .background(Constants.textFieldColor)
                    .cornerRadius(5.0)
                    .frame(maxWidth: 350)
                
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
                
                if (utils.error != nil){
                    Text("You need to sign up bro")
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    self.utils.logInUser(email: self.email, password: self.password)
                    if self.utils.error != nil{
                        // Display error message
                        print(self.utils.error!)
                    }
                }){
                    NavTextField(field:"LOG IN")
                }.padding()
                
                Spacer()
                
            }.padding()
        }
        .frame(maxWidth: .infinity)
        .background(Constants.mainColor)
        .edgesIgnoringSafeArea([.top, .bottom])
        .KeyboardResponsive()
    }
    
}

struct LoginSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSwiftUIView()
    }
}
