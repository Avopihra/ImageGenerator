//
//  FavoritesPresenter.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import Foundation

class FavoritesPresenterImpl: FavoritesPresenter {
    
    //MARK: - Properties
    
    let view: FavoritesViewProtocol
    let imageData: ImageData
    var rowsCount: Int {
        return self.favoritesService.getFavorites().count
    }
    
    //MARK: - Private Properties

    private lazy var favoritesService: FavoritesService = {
        let favoritesService: FavoritesService = FavoritesService()
        favoritesService.delegate = self
        return favoritesService
    }()
    
    //MARK: - Init

    required init(view: FavoritesViewProtocol, data: ImageData) {
        self.view = view
        self.imageData = data
       self.favoritesService.delegate = self
    }
    
    //MARK: - Protocol Methods

    func getFavorites() {
        let favorites = self.favoritesService.getFavorites()
        self.view.displayFavorites(favorites)
    }
    
    func removeFromFavorites(at index: Int) {
        self.favoritesService.removeFavorite(at: index)
        self.getFavorites()
    }
}

//MARK: - FavoriteProtocol Methods

extension FavoritesPresenterImpl: FavoriteViewDelegate {
    func updateFavoritesList(_ favorites: [ImageData]) {
        self.view.displayFavorites(favorites)
    }
}
