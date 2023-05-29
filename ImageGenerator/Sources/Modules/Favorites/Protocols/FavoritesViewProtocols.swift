//
//  FavoriteViewProtocols.swift
//  ImageGenerator
//
//  Created by Viktoriya on 27.05.2023.
//

import UIKit

//MARK: - View Protocol

protocol FavoritesViewProtocol: AnyObject {
    func displayFavorites(_ favorites: [ImageData])
    func displayError(_ message: String)
}

//MARK: - Presenter Protocol

protocol FavoritesPresenter: AnyObject {
    init(view: FavoritesViewProtocol, data: ImageData)
    var rowsCount: Int { get }
    func getFavorites()
    func removeFromFavorites(at index: Int)
}
