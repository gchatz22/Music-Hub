//
//  Constants.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/23/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation
import SwiftUI


struct Constants {
    static let SpotifyClientID = "f821b90b6ee34c76aef11d5ab4bac3db"
    static let SpotifyClientSecret = "8633a836a6114a4887620fca24b2c487"
    static let SpotifyRedirectURL = URL(string: "music-hub://spotify-login-callback")!
    static let sessionKey = "spotifySessionKey"
    
    static let mainColor: Color = Color(red: 25/255, green: 20/255, blue: 20/255)
//    static let mainColor: Color = Color(.white)
    static let buttonColor: Color = Color(red: 30/255, green: 215/255, blue: 96/255)
    static let textFieldColor: Color = Color(red: 64/255, green: 64/255, blue: 64/255)
}
