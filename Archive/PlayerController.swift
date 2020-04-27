//
//  PlayerController.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/24/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation

class PlayerController: NSObject{
    
    static let shared = PlayerController()
    private let spotifyPlayer: SPTUser
    private var queueController: PlayerQueueController
//    private var spotifyIsConnected: Bool
    
    private override init() {

        spotifyPlayer = SPTUser()
        queueController = PlayerQueueController()
//        spotifyIsConnected = false
    }
    
    func getUserAPI() -> SPTAppRemotePlayerAPI? {
        return self.spotifyPlayer.getUserAPI()
    }
    
    func queueSongs(songs: [Song]) {
        self.queueController.queueSongs(songs: songs)
    }
    
    func playAndQueue(songs: [Song]) {
        self.queueController.clear()
        self.queueController.queueSongs(songs: songs)
        let s = self.queueController.nextSong()
        self.playSong(song: s)
    }
    
    
    func queueSong(song: Song) {
        PlayerController.shared.queueController.queueSong(song: song)
    }
    
    func playSong(song: Song) {
        let s : Song = PlayerController.shared.queueController.playSong(song: song)
        print(s)
        PlayerController.shared.spotifyPlayer.playSong(song: s)
    }
    
    
    private func songChangeCallback() {
        if PlayerController.shared.queueController.canGoToNext() {
            let song = queueController.nextSong()
            PlayerController.shared.spotifyPlayer.playSong(song: song)
        }
    }
    
    
    func reactivate() {
        PlayerController.shared.spotifyPlayer.reactivate()
    }
    func deactivate() {
        PlayerController.shared.spotifyPlayer.deactivate()
    }
    
    func setSpotifyAccessTokenAndConnect(accessToken: String) {
//        self.spotifyIsConnected = self.spotifyPlayer.setAccessTokenAndConnect(accessToken: accessToken)
        self.spotifyPlayer.setAccessTokenAndConnect(accessToken: accessToken)
        self.spotifyPlayer.setSongChangeCallback(songChangeCallback: self.songChangeCallback)
    }
    
    func spotifyConnected() -> Bool {
//        return self.spotifyIsConnected
        return self.spotifyPlayer.appRemote.isConnected
    }
    
    
    
    func authorizationParameters(from: URL) -> [String: String]? {
        return self.spotifyPlayer.appRemote.authorizationParameters(from: from)
        
    }
    
    
}



