//
//  User.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/26/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation


class User : NSObject, SPTAppRemoteUserAPI, SPTAppRemoteUserAPIDelegate, SPTAppRemoteUserCapabilities, ObservableObject, Identifiable{
    
    static let shared: User = User()
    
    var uid: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    
    var delegate: SPTAppRemoteUserAPIDelegate?
    var canPlayOnDemand: Bool = false
    @Published var streamingConnected: Bool = false
    @Published var friends: [User] = []
    @Published var hosting: Bool = false

    init (uid: String = "", firstName: String = "", lastName: String = "", email: String = ""){
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    func setParams(uid: String = "", firstName: String = "", lastName: String = "", email: String = ""){
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        print("Set User params")
    }

    
    
    
    
    
    
    
    
    
    func fetchCapabilities(callback: SPTAppRemoteCallback? = nil) {
        print("fethched capabilities")
    }
    
    func subscribe(toCapabilityChanges callback: SPTAppRemoteCallback? = nil) {
        print("subscribed to capability changes")
    }
    
    func unsubscribe(toCapabilityChanges callback: SPTAppRemoteCallback? = nil) {
        print("unsubscribed from capability changes")
    }
    
    func fetchLibraryState(forURI URI: String, callback: @escaping SPTAppRemoteCallback) {
        print("fethched library state")
    }
    
    func addItemToLibrary(withURI URI: String, callback: @escaping SPTAppRemoteCallback) {
        print("added item to library")
    }
    
    func removeItemFromLibrary(withURI URI: String, callback: @escaping SPTAppRemoteCallback) {
        print("removed item from library")
    }
    
    
    func userAPI(_ userAPI: SPTAppRemoteUserAPI, didReceive capabilities: SPTAppRemoteUserCapabilities) {
        print("received new capabilities")
        print(capabilities)
        if (capabilities.canPlayOnDemand){
            print("User can play on demand :)")
            canPlayOnDemand = true
        } else {
            print("User cannot play on demand :(")
            canPlayOnDemand = false
        }
    }
    
}
