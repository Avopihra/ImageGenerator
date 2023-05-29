//
//  Coordinator.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

class AppCoordinator {
    
    //MARK: - Private Properties
    
    private let window: UIWindow
    private let imageService: ImageService
    private let favoritesService: FavoritesService
    
    init(window: UIWindow) {
        self.window = window
        self.imageService = ImageService()
        self.favoritesService = FavoritesService()
    }
    
    //MARK: - Build Modules

    func start() {
        let tabBarController = UITabBarController()
        
        // Main Module
        let mainViewController = ModuleBuilder.createMainModule()
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        mainNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        // Favorites Module
        let favoritesViewController = ModuleBuilder.createFavoritesModule()
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        favoritesNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        tabBarController.viewControllers = [mainNavigationController, favoritesNavigationController]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
