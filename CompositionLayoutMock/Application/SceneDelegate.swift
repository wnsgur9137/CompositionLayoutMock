//
//  SceneDelegate.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 12/1/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let appDIContainer = AppDIContainer()
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let sceneDIContainer = appDIContainer.makeMainSceneDIContainer()
        let tabBarController = sceneDIContainer.makeMainTabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

