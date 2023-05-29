//
//  ModuleBuilder.swift
//  ImageGenerator
//
//  Created by Viktoriya on 27.05.2023.
//

import UIKit

//MARK: - Builder Logic

protocol ModuleBuilderProtocol {
    static func createMainModule() -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenterImpl(view: view)
        view.setup(presenter: presenter)
        return view
    }
    
    static func createFavoritesModule() -> UIViewController {
        let data = ImageData(data: Data(), request: "", isFavorite: false)
        let view = FavoritesViewController()
        let presenter = FavoritesPresenterImpl(view: view, data: data)
        view.setup(presenter: presenter)
        return view
    }
}
