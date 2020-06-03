//
//  SceneDelegate.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 4/16/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("opening url from scene")

        guard let url = URLContexts.first?.url else {
            print("cant open url")
            return
        }
        
        let parameters = Controller.shared.authorizationParameters(from: url)
        
        if let _ = parameters?["code"] {
            let options_new: [UIApplication.OpenURLOptionsKey: Any] = [
                UIApplication.OpenURLOptionsKey.openInPlace: true
            ]

            
            DispatchQueue.main.async {
                SpotifyManager.shared.sessionManager.application(UIApplication.shared, open: url, options: options_new)
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
            
            SPTAppRemote.checkIfSpotifyAppIsActive({ (val) in
                print(val)
            })
            
            let user_id = Database.currentUserID()
            
            if user_id != nil{
                print("You are already authenticated in this device")
                SpotifyManager.shared.initiateSPTSession()
                self.redirect(view: AnyView(HomeSwiftUIView()))
            } else {
                print("You need to authenticate")
                self.redirect(view: AnyView(IntroSwiftUIView()))
            }
            
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
            // Called as the scene is being released by the system.
            // This occurs shortly after the scene enters the background, or when its session is discarded.
            // Release any resources associated with this scene that can be re-created the next time the scene connects.
            // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
            print("sceneDidDisconnect")
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
        }

        func sceneDidEnterBackground(_ scene: UIScene) {
            // Called as the scene transitions from the foreground to the background.
            // Use this method to save data, release shared resources, and store enough scene-specific state information
            // to restore the scene back to its current state.
            
    //        print("sceneDidEnterBackground")
        }

}
