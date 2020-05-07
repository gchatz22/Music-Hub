//
//  Database.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 5/3/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
//import SwiftUI

class Database{
    
    public static let device = [UIDevice.current.identifierForVendor! .uuidString][0]
    private static var user_id: String = ""
    private static let db = Firestore.firestore()
    
    init(){
        FirebaseApp.configure()
    }
    
    static func signUpUser(email: String, uid: String, firstName: String, lastName: String){
        let newDoc = self.db.collection("users").addDocument(data: ["email": email, "uid": uid, "firstName": firstName, "lastName": lastName, "device": [self.device]]) { (err) in
            if err != nil {
                print(err!.localizedDescription)
            } else {
                print("Success! Signed up user in database")
            }
        }
        
        self.db.collection("devices").document(self.device).setData(["user_ref_id": newDoc.documentID]){ (err) in
            if err != nil {
                print(err!.localizedDescription)
            } else {
                print("Also made new device/user reference")
            }
        }
    }
    
    static func setLocalUserId(uid: String){
        print("set user_id to", uid)
        self.user_id = uid
    }
    
    static func getRef(collection: String, uid: String) -> DocumentReference{
        return db.collection(collection).document(uid)
    }
    
    static func setActive(active: Bool){
        if self.user_id != "" {
            self.db.collection("users").document(self.user_id).updateData([ "active": active ])
            print("User active:", active)
        }
//        else {
//            print("No user id to set activity")
//        }
    }
    
    
    
    
}
