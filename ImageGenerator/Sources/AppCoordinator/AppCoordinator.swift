//
//  Coordinator.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

class AppCoordinator {
    private let window: UIWindow
    private let imageService: ImageServiceProtocol?
    private let favoritesService: FavoritesServiceProtocol?
    
    init(window: UIWindow) {
        self.window = window
        self.imageService = ImageService()
        self.favoritesService = FavoritesService()
    }
    
    func start() {
        let tabBarController = UITabBarController()
        
        // Main Module
        let mainViewController = MainViewController.create()
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        mainNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        // Favorites Module
        let favoritesViewController = FavoritesViewController.create()
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        favoritesNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        tabBarController.viewControllers = [mainNavigationController, favoritesNavigationController]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
