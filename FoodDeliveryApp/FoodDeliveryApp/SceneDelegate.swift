//
//  SceneDelegate.swift
//  FoodDeliveryApp
//
//  Created by Vova Lincore on 24.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let viewController = ViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        
        let appCoordinator = AppCoordinator(type: .app, navigationController: navigationController, window: window)
        self.coordinator = appCoordinator
        appCoordinator.start()
    }


}

