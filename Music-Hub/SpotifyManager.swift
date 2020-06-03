//
//  SpotifyManager.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 5/21/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation


class SpotifyManager: NSObject, SPTSessionManagerDelegate{
    
    static let shared: SpotifyManager = SpotifyManager()
    static private let kAccessTokenKey = "access-token-key"
    static private let sptSessionKey = "spotify-session-key"
    static private let user: User = User.shared
    
    
    
    func initiateSPTSession(){
        let session = self.getSession()
        if session == nil{
            self.sessionManager.session = session
            self.sessionManager.renewSession()
            print("renewing session")
        } else {
            let requestedScopes: SPTScope = [.appRemoteControl]
            self.sessionManager.initiateSession(with: requestedScopes, options: .default)
            print("initiated session")
        }
    }
    

//    var accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey) {
//        didSet {
//            print("set access token")
//            let defaults = UserDefaults.standard
//            defaults.set(accessToken, forKey: SpotifyManager.kAccessTokenKey)
//        }
//    }
    
    lazy var configuration = SPTConfiguration(
        clientID: Constants.SpotifyClientID,
        redirectURL: Constants.SpotifyRedirectURL
    )
    
    lazy var sessionManager: SPTSessionManager = {
        if let tokenSwapURL = URL(string: "https://gchatz-music-hub.herokuapp.com/api/token"),
           let tokenRefreshURL = URL(string: "https://gchatz-music-hub.herokuapp.com/api/refresh_token") {
            self.configuration.tokenSwapURL = tokenSwapURL
            self.configuration.tokenRefreshURL = tokenRefreshURL
            self.configuration.playURI = ""
        }
        
        let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
//        manager.alwaysShowAuthorizationDialog = false // CHANGE FOR DEBUG
        print("started session manager")
        return manager
    }()
    
        
    func storeSession(_ session: SPTSession) {
        do{
            let sessionData = try NSKeyedArchiver.archivedData(withRootObject: session, requiringSecureCoding: true)
            UserDefaults.standard.setValue(sessionData, forKey: SpotifyManager.sptSessionKey)
            UserDefaults.standard.synchronize()
            print("strored session")
        } catch{
            print(error)
        }
    }
    
    func getSession() -> SPTSession?{
        if let sessionData = UserDefaults.standard.value(forKey: SpotifyManager.sptSessionKey) as? Data {
            do{
                let session = try NSKeyedUnarchiver.unarchivedObject(ofClass: SPTSession.self, from: sessionData)
                return session
            } catch{
                print(error)
                return nil
            }
//            return session
        } else {
            return nil
        }
    }
        
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("got access token: ", session.accessToken)
        SpotifyManager.user.streamingConnected = true
        
        DispatchQueue.main.async {
            Controller.shared.setSpotifyAccessTokenAndConnect(accessToken: session.accessToken)
        }
        self.storeSession(session)
        print("session initiated!")
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print(error)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        SpotifyManager.user.streamingConnected = true
        
        DispatchQueue.main.async {
            Controller.shared.setSpotifyAccessTokenAndConnect(accessToken: session.accessToken)
//            print("Spotify connected: ", Controller.shared.spotifyConnected())
            //self.appRemote.connect()
        }
        print("session renewed!")
    }
    
}
