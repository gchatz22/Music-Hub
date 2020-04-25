//
//  SPTUser.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/24/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation

class SPTUser: NSObject, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate/*, SPTSessionManagerDelegate*/{
    
//    let SpotifyClientID: String  = ""
//    let SpotifyRedirectURL: URL  = Constants.SpotifyRedirectURL
    
    var songChangeCallback: () -> ()
    var currentSong: Song
    var playing: Bool = false

    lazy var configuration = SPTConfiguration(
        clientID: Constants.SpotifyClientID,
        redirectURL: Constants.SpotifyRedirectURL
    )
    
    private var accessToken: String
    
    lazy var appRemote: SPTAppRemote = {
           
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        self.configuration.playURI = ""
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        print("made app remote")
        return appRemote
    }()

    
    override init() {
        songChangeCallback = {} //songChangeCallback
        currentSong = Song()
        accessToken = "invalid"
    }
    

    
    func setSongChangeCallback(songChangeCallback: @escaping () -> ()) {
        self.songChangeCallback = songChangeCallback
    }
    
    
    func isPlaying() -> Bool {
        return playing
    }
    
    private func handleConnection() {
        if !appRemote.isConnected {
            appRemote.connect()
        }
    }
    
    func playSong(song: Song) {
        handleConnection()
        currentSong = song
//        if !(song is PoisonSong) {
//            DispatchQueue.main.async {
//                self.playing = true
//                self.appRemote.playerAPI?.play(song.playableID)
//            }
//        }
    }
    
    func play() {
        handleConnection()
        DispatchQueue.main.async {
            self.appRemote.playerAPI?.play("")
            self.playing = true
        }
    }
    
    func pause() {
        handleConnection()
        DispatchQueue.main.async {
            self.appRemote.playerAPI?.pause()
            self.playing = false
        }
    }
    
    func skip() {
        handleConnection()
        pause()
        currentSong = Song()
        self.songChangeCallback()
        playing = false
    }
    
    func startSongOver() {
        handleConnection()
        DispatchQueue.main.async {
            self.appRemote.playerAPI?.seek(toPosition: 0)
        }
    }
    
    func getCurrentSong() -> Song {
        return currentSong
    }
    
    
    
    func setAccessTokenAndConnect(accessToken: String) -> Bool{
        self.accessToken = accessToken
        self.appRemote.connectionParameters.accessToken = accessToken
        print("App remote is connecting ...")
        self.appRemote.connect()
        return self.appRemote.isConnected
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("App remote connected: ", PlayerController.shared.spotifyConnected())
        
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        })
        
       // Want to play a new track?
       // self.appRemote.playerAPI?.play("spotify:track:13WO20hoD72L0J13WTQWlT", callback: { (result, error) in
       //     if let error = error {
       //         print(error.localizedDescription)
       //     }
       // })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("failed")
    }

    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print("player state changed")
        print("Spotify connected: ", PlayerController.shared.spotifyConnected())
        print("isPaused", playerState.isPaused)
        print("track.uri", playerState.track.uri)
        if(playerState.track.uri != currentSong.playableID) {
            songChangeCallback()
        }
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
    
    func reactivate() {
        
        if let _ = self.appRemote.connectionParameters.accessToken {
            self.appRemote.connect()
        }
    }
    
    func deactivate() {
        
        if self.appRemote.isConnected {
            self.appRemote.disconnect()
        }
    }
    
}
