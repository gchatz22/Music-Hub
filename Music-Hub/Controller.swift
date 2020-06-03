//
//  Controller.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/26/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation
import AVFoundation

class Controller: NSObject {
    
    public static var shared = Controller()
    private var spotifyPlayer: Player
    private var spotifyUser: User
    
    override init (){
        spotifyPlayer = Player()
        spotifyUser = User.shared
    }
    
    func test(){
        self.spotifyPlayer.appRemote.connect()
        print("API", self.spotifyPlayer.appRemote.playerAPI)
    }
    
    func playSong(){
        print("playing song")
//        self.spotifyPlayer.appRemote.playerAPI?.play("spotify:track:7egj375ez0KtF3bYCfAHdZ")
        print(self.spotifyPlayer.appRemote.isConnected)
//        self.spotifyPlayer.play()
    
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
