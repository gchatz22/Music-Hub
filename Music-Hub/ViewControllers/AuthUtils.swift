//
//  SignUpUtils.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 5/2/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation
import FirebaseAuth
import SwiftUI


class AuthUtils: ObservableObject {
    
    @Published var error: String? = nil
    
    func makeNewUser(email: String, password: String, firstName: String, lastName: String){
        let valError = self.validateFields(email: email, password: password)
        var uid:String = "narp"
        
        if valError==nil{
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil{
                    let authErr = err!.localizedDescription
                    if (authErr == "The email address is already in use by another account."){
                        print("You already have an account. Go to login!")
                        self.error = "You already have an account. Go to login!"
                    } else {
                        print(authErr)
                    }
                } else {
                    // Create User
                    print("Creating User")
                    AppState.enterHome()
                    uid = result!.user.uid
                    Database.connectedUserSetup(user_uid: uid)
                    Database.signUpUser(email: email, uid: uid, firstName: firstName, lastName: lastName)
                }
                
            }
            
        } else{
            // Display error message for email or password
            print(valError!)
            self.error = valError
        }
    }
    
    func validateFields(email: String, password: String) -> String?{
        if email.trimmingCharacters(in: .whitespacesAndNewlines)=="" || password.trimmingCharacters(in: .whitespacesAndNewlines)==""{
            return "Please fill in all the fields!"
        }
        
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Change in production
        
//        if self.isPasswordValid(cleanPassword)==false{
//            return "Invalid Password Selection"
//        }
//
        return nil
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func logInUser(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if error != nil{
                print(error!.localizedDescription)
                self.error = error!.localizedDescription
            } else {
                print(authResult!)
                AppState.enterHome()
                
            }
        }
    }
    
    
    
}
