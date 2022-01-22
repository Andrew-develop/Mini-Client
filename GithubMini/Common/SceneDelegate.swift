//
//  SceneDelegate.swift
//  GithubMini
//
//  Created by Sergio Ramos on 20.01.2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        let window = UIWindow(windowScene: windowScene)
        let rootVC = UserDefaults.standard.string(forKey: UserDefaultsKey.token) != nil ? ReposAssembly.build() : LoginAssembly.build()
        let navigation = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
    }
}

