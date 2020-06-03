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
    private static let user: User = User.shared
    
    init(){
        FirebaseApp.configure()
        
    }
    
    static func currentUserID() -> String?{
        let user = Auth.auth().currentUser
        
        if user == nil{
            return nil
        } else {
            self.user.uid = user!.uid
            self.getFriends()
//            Need to use user defaults to get the rest of user info
//            TODO
            
            return user!.uid
        }
        
    }
    
    static func signUpUserInDB(email: String, uid: String, firstName: String, lastName: String){
        
        let userDoc = self.createRef(collection: "users", uid: uid)
        
        userDoc.setData(["uid": uid, "email": email, "firstName": firstName, "lastName": lastName]) { (err) in
            if err != nil {
                print(err!.localizedDescription)
            } else {
                print("Success! Signed up user in database")
                self.user.setParams(uid: uid, firstName: firstName, lastName: lastName, email: email)
            }
        }
        
    }
    
    static func getFriends(){
//        CHANGE: For now it returns all users
        Database.db.collection("users").getDocuments { (result, err) in
            
            if result == nil{
                self.user.friends = []
            } else {
                let arr = result!.documents
                var friends: [User] = []
                
                for inst in arr {
                    let data = inst.data()
                    friends.append(User(uid: data["uid"] as! String, firstName: data["firstName"] as! String, lastName: data["lastName"] as! String, email: data["email"] as! String))
                }
                
                self.user.friends = friends
            }
        }
        
    }

    static func createRef(collection: String, uid: String) -> DocumentReference{
        return db.collection(collection).document(uid)
    }
    
    static func logout(){
        self.user.streamingConnected = false
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("logged out")
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
