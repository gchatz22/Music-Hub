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
import FirebaseAuth

class Database{
    
    public static let device = [UIDevice.current.identifierForVendor! .uuidString][0]
    private static let db = Firestore.firestore()
    
    init(){
        FirebaseApp.configure()
    }
    
    static func currentUserID() -> String?{
        let user = Auth.auth().currentUser
//        print(user)
        
        if user == nil{
            return nil
        } else {
            return user!.uid
        }
        
    }
    
    static func signUpUser(email: String, uid: String, firstName: String, lastName: String){
        
        let userDoc = self.createRef(collection: "users", uid: uid)
        
        userDoc.setData(["email": email, "firstName": firstName, "lastName": lastName]) { (err) in
            if err != nil {
                print(err!.localizedDescription)
            } else {
                print("Success! Signed up user in database")
            }
        }
        
    }
    
    static func connectedUserSetup(user_uid: String){
        self.setActive(active: true)
        self.streamingConnected(connected: false)
//        AppState.initiateSPTSession()
    }
    
    static func streamingConnected(connected: Bool){
        let uid = self.currentUserID()!
        self.db.collection("users").document(uid).updateData([ "streaming_connected": connected ])
    }
    
    static func createRef(collection: String, uid: String) -> DocumentReference{
        return db.collection(collection).document(uid)
    }
    
    static func logout(){
        print("logging out")
        
        self.setActive(active: false)
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
        AppState.logout()

    }
    
    static func setActive(active: Bool){
        let uid = self.currentUserID()!
        if uid != "" {
            self.db.collection("users").document(uid).updateData([ "active": active ])
            print("User active:", active)
        }
//        else {
//            print("No user id to set activity")
//        }
    }
    
    
    
    
}
