//
//  SceneDelegate.swift
//  SampleArchitecture
//
//  Created by user on 06.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    let keychainService = KeyChainService()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        keychainService.getUserCredentials()
                .subscribe(
                        onSuccess: { creds in self.instantiateFlow(scene: scene, storyboard: AppStoryboard.Main) },
                        onError: { creds in self.instantiateFlow(scene: scene, storyboard: AppStoryboard.Login) }
                )
    }

    private func instantiateFlow(scene: UIScene, storyboard: AppStoryboard) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
        self.window?.rootViewController = storyboard.instance.instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
    }
}

