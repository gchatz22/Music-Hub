//
//  AppState.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 5/9/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation
import SwiftUI


class AppState: ObservableObject{
    
    private static let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    
    static func logout(){
        AppState.delegate?.redirect(view: AnyView(IntroSwiftUIView()))
    }
    
    static func enterHome(){
        AppState.delegate?.redirect(view: AnyView(HomeSwiftUIView()))
    }
    
    static func initiateSPTSession(){
        SpotifyManager.shared.initiateSPTSession()
    }
    
}
