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


class SignUpUtils {
    
    static func makeNewUser(email: String, password: String, firstName: String, lastName: String) -> String?{
        var error = SignUpUtils.validateFields(email: email, password: password)
        var uid:String = "narp"
        
        if error==nil{
            // Create User
            print("Creating User")
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil{
                    error = err!.localizedDescription
                    print(error!)
                } else {
//                    print(result!)
                    uid = result!.user.uid
                    Database.setLocalUserId(uid: uid)
                    Database.setActive(active: true)
                    error = nil
                }
                
                if (error == "The email address is already in use by another account."){
                    print("You already have an account. Go to login!")
                } else if (error == nil){
                    Database.signUpUser(email: email, uid: uid, firstName: firstName, lastName: lastName)
                } else {
                    print(error!)
                }
                
                
                
            }
            
        } else{
            // Display error message for email or password
            print(error!)
        }
        
        return error
    }
    
    static func validateFields(email: String, password: String) -> String?{
        if email.trimmingCharacters(in: .whitespacesAndNewlines)=="" || password.trimmingCharacters(in: .whitespacesAndNewlines)==""{
            return "Please fill in all the fields!"
        }
        
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Change in production
        
//        if SignUpUtils.isPasswordValid(cleanPassword)==false{
//            return "Invalid Password Selection"
//        }
        
        return nil
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}
