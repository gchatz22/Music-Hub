//
//  Controller.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/26/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation

class Controller: NSObject {
    
    private var spotifyPlayer: Player
    private var spotifyUser: User
    public static var shared = Controller()
    
    override init (){
        spotifyPlayer = Player()
        spotifyUser = User()
    }
    
    func authorizationParameters(from: URL) -> [String: String]? {
        return self.spotifyPlayer.appRemote.authorizationParameters(from: from)
    }
    
    func setSpotifyAccessTokenAndConnect(accessToken: String) {
            self.spotifyPlayer.setAccessTokenAndConnect(accessToken: accessToken)
    }
    
    func setUserDelegate(){
        spotifyUser.delegate = spotifyUser
        spotifyUser.subscribe(toCapabilityChanges: { (result, error) in if let error = error {
                debugPrint(error.localizedDescription)
            }
        })
    }
    
    func spotifyConnected() -> Bool{
        return self.spotifyPlayer.appRemote.isConnected
    }
    
}
