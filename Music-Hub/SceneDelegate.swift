//
//  SceneDelegate.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/16/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate, SPTSessionManagerDelegate {
    
    var window: UIWindow?
    
    static private let kAccessTokenKey = "access-token-key"

    var accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey) {
        didSet {
            print("set access token")
            let defaults = UserDefaults.standard
            defaults.set(accessToken, forKey: SceneDelegate.kAccessTokenKey)
        }
    }
    
    
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
        manager.alwaysShowAuthorizationDialog = false // CHANGE FOR DEBUG
        print("started session manager")
        return manager
    }()
    
    
    func initiateSPTSession(){
        let requestedScopes: SPTScope = [.appRemoteControl]
        self.sessionManager.initiateSession(with: requestedScopes, options: .default)
        print("initiated session")
    }
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("opening url from scene")
//        print(URLContexts.first?.url)
        guard let url = URLContexts.first?.url else {
            print("cant open url")
            return
        }
        
//        guard let options = URLContexts.first?.options else {
//            print("cant get options")
//            return
//        }
//        print(options)
        
        let parameters = Controller.shared.authorizationParameters(from: url)
//        print(parameters)
        
        if let _ = parameters?["code"] {
            let options_new: [UIApplication.OpenURLOptionsKey: Any] = [
                UIApplication.OpenURLOptionsKey.openInPlace: true
            ]

            
            DispatchQueue.main.async {
                self.sessionManager.application(UIApplication.shared, open: url, options: options_new)
            }
            
        } else if let _ = parameters?[SPTAppRemoteErrorDescriptionKey] {
            // Show the error
            print("error in scene open")
        }
        print("opened url")

    }
    
    func redirect(view: AnyView){
        if let window = self.window {
            window.rootViewController = UIHostingController(rootView: view)
            window.makeKeyAndVisible()
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        // Create the SwiftUI view that provides the window contents.
        
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            
            let devRef = Database.getRef(collection: "devices", uid: Database.device)

            devRef.getDocument { (document, error) in
                let logged_in = document?.exists ?? false

                if (logged_in == true){
                    print("You are already authenticated in this device")
                    self.redirect(view: AnyView(HomeSwiftUIView()))
                    Database.connectedUserSetup(user_uid: document!.get("user_ref_id") as! String)
                } else {
                    print("You need to authenticate")
                    self.redirect(view: AnyView(IntroSwiftUIView()))
                }


            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("sceneDidDisconnect")
        Database.setActive(active: false)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        
//        print(self.appRemote.connectionParameters)
//        print(self.appRemote.connectionParameters.accessToken)
//        print(self.appRemote.connectionParameters.authenticationMethods)
        
//        DispatchQueue.main.async { [weak self] in
//            self?.appRemote.connect()
//        }
        
//        print("sceneDidBecomeActive")
//        Database.setActive(active: true)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        
        /*
        DispatchQueue.main.async { [weak self] in
            self?.appRemote.disconnect()
        }*/
        
//        print("sceneWillResignActive")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
//        print("sceneWillEnterForeground")
//        Database.setActive(active: true)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
//        print("sceneDidEnterBackground")
//        Database.setActive(active: false)
    }
    
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("got access token: ", session.accessToken)
        //self.appRemote.connectionParameters.accessToken = session.accessToken
        //print(self.appRemote.connectionParameters.accessToken)
        
        DispatchQueue.main.async {
            Controller.shared.setSpotifyAccessTokenAndConnect(accessToken: session.accessToken)
            //self.appRemote.connect()
        }
        print("session initiated!")
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print(error)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print(session)
        
        DispatchQueue.main.async {
            Controller.shared.setSpotifyAccessTokenAndConnect(accessToken: session.accessToken)
            print("Spotify connected: ", Controller.shared.spotifyConnected())
            //self.appRemote.connect()
        }
        print("session renewed!")
    }

}
