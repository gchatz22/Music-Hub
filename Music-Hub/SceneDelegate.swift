//
//  SceneDelegate.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/16/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import UIKit
import SwiftUI
//import SwiftSoup

class SceneDelegate: UIResponder, UIWindowSceneDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {

    var accessToken = ""
    var playURI = ""
    
    var window: UIWindow?
    
    lazy var configuration = SPTConfiguration(
      clientID: Constants.SpotifyClientID,
      redirectURL: Constants.SpotifyRedirectURL
    )
    
    lazy var appRemote: SPTAppRemote = {
      let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
      appRemote.connectionParameters.accessToken = self.accessToken
      appRemote.delegate = self
      return appRemote
    }()
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        print("I am in the main scene")
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
        
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("I am in the URL scene")
        
        guard let url = URLContexts.first?.url else {
            return
        }
        let parameters = appRemote.authorizationParameters(from: url);
//
        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = access_token
            self.accessToken = access_token
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print(error_description)
        }
    }

    
    
    func connect() {
      self.appRemote.authorizeAndPlayURI(self.playURI)
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
      // Connection was successful, you can begin issuing commands
      self.appRemote.playerAPI?.delegate = self
      self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
        if let error = error {
          debugPrint(error.localizedDescription)
        }
      })
    }
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
      print("disconnected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
      print("failed")
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
      debugPrint("Track name: %@", playerState.track.name)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
//      if let _ = self.appRemote.connectionParameters.accessToken {
//        self.appRemote.connect()
//      }
    }

    func sceneWillResignActive(_ scene: UIScene) {
      if self.appRemote.isConnected {
        self.appRemote.disconnect()
      }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

