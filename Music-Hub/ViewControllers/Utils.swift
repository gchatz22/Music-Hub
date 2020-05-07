//
//  Utils.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 5/2/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation
import FirebaseAuth


class SignUpUtils {
    
    static func makeNewUser(email: String, password: String) -> String?{
        let error = SignUpUtils.validateFields(email: email, password: password)
        
        if error==nil{
            // Create User
            print("Creating User")
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil{
                    print(err!.localizedDescription)
                } else {
                    print(result!)
                }
            }
            
            
            
            return nil
            
        } else{
            // Display error message
            
            print(error!)
            return error!
        }
    }
    
    static func validateFields(email: String, password: String) -> String?{
        if email.trimmingCharacters(in: .whitespacesAndNewlines)=="" || password.trimmingCharacters(in: .whitespacesAndNewlines)==""{
            return "Please fill in all the fields!"
        }
        
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
//        if Utils.isPasswordValid(cleanPassword)==false{
//            return "Invalid Password Selection"
//        }
        
        return nil
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}
