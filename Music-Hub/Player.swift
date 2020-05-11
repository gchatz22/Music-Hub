//
//  Player.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/26/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation


class Player: NSObject, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate{
    
    private var accessToken: String
    
    lazy var configuration = SPTConfiguration(
        clientID: Constants.SpotifyClientID,
        redirectURL: Constants.SpotifyRedirectURL
    )
    
    lazy var appRemote: SPTAppRemote = {
           
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        self.configuration.playURI = ""
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        print("made app remote")
        return appRemote
    }()
    
    
    override init() {
        accessToken = "invalid"
    }
    
    func play() {
        handleConnection()
        DispatchQueue.main.async {
            self.appRemote.playerAPI?.play("")
        }
    }
    
    func playSong(track: SPTAppRemoteTrack){
        handleConnection()
        DispatchQueue.main.async {
            self.appRemote.playerAPI?.play(track.uri)
        }
    }
    
    func pause(){
        handleConnection()
        DispatchQueue.main.async {
            self.appRemote.playerAPI?.pause()
        }
    }
    
    
    
    private func handleConnection() {
        if (!appRemote.isConnected) {
            appRemote.connect()
        }
    }
    
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print("player state changed")
        print("Spotify connected: ", Controller.shared.spotifyConnected())
        print("isPaused", playerState.isPaused)
        print("track.uri", playerState.track.uri)
//        if(playerState.track.uri != currentSong.playableID) {
//            songChangeCallback()
//        }
        print("track.name", playerState.track.name)
        print("track.imageIdentifier", playerState.track.imageIdentifier)
        print("track.artist.name", playerState.track.artist.name)
        print("track.album.name", playerState.track.album.name)
        print("track.isSaved", playerState.track.isSaved)
        print("playbackSpeed", playerState.playbackSpeed)
        print("playbackOptions.isShuffling", playerState.playbackOptions.isShuffling)
        print("playbackOptions.repeatMode", playerState.playbackOptions.repeatMode.hashValue)
        print("playbackPosition", playerState.playbackPosition)
    }
    
    func setAccessTokenAndConnect(accessToken: String){
        self.accessToken = accessToken
        self.appRemote.connectionParameters.accessToken = accessToken
        print("App remote is connecting ...")
        self.appRemote.connect()
    }
    
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("App remote connected: ", Controller.shared.spotifyConnected())
        Database.streamingConnected(connected: true)
        
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        })
        
        Controller.shared.setUserDelegate()
    }
    
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print(error!.localizedDescription)
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print(error!.localizedDescription)
    }
}
