//
//  SceneDelegate.swift
//  Movies
//
//  Created by Alex Bro on 20.12.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = .beige
        let assembly = AssemblyService()
        let router = RouterService(navigationController: navigationController, assembly: assembly)
        router.initialViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
