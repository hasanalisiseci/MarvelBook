//
//  SceneDelegate.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 7.08.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let tabBarController = UITabBarController()

        let characterViewController = CharactersCollectionVC()
        characterViewController.view.backgroundColor = .red
        characterViewController.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person.2.fill"), tag: 0)
        characterViewController.navigationItem.title = "Characters"

        let comicsViewController = ComicsCollectionVC()
        comicsViewController.view.backgroundColor = .blue
        comicsViewController.tabBarItem = UITabBarItem(title: "Comics", image: UIImage(systemName: "books.vertical.fill"), tag: 1)
        comicsViewController.navigationItem.title = "Comics"

        tabBarController.viewControllers = [characterViewController, comicsViewController]

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: tabBarController)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
