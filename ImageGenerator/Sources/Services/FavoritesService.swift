//
//  FavoritesService.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit
import SQLite

//MARK: - Service Protocol

protocol FavoritesServiceProtocol {
    func addToFavorites(image: UIImage, request: String)
    func removeFavorite(at index: Int)
    func getFavorites() -> [ImageData]
    func saveFavorites(_ favorites: [ImageData])
}

protocol FavoriteViewDelegate {
    func updateFavoritesList(_ favorites: [ImageData])
}

// MARK: - Service
class FavoritesService: FavoritesServiceProtocol {
    
    private var favorites: [ImageData] = []
    private let maxFavoritesCount = 10
    
    var delegate: FavoriteViewDelegate?
    let cacheManager = CacheManager()
    
    func removeFavorite(at index: Int) {
        var favorites = cacheManager.getFavorites()
        guard index >= 0 && index < favorites.count else {
            return
        }
        
        let removedFavorite = favorites.remove(at: index)
        cacheManager.saveFavorites(favorites)
        delegate?.updateFavoritesList(favorites)
        cacheManager.removeFavorite(request: removedFavorite.request)
    }
    
    func addToFavorites(image: UIImage, request: String) {
        var favorites = getFavorites()
        if favorites.count >= maxFavoritesCount {
            removeOldestFavorite()
            favorites = getFavorites()
        }
        
        let data = image.jpegData(compressionQuality: 1.0)
        
        let newFavorite = ImageData(data: data, request: request, isFavorite: true)
        
        if !favorites.contains(where: { $0.data == data && $0.request == request }) {
            favorites.append(newFavorite)
            saveFavorites(favorites)
            delegate?.updateFavoritesList(favorites)
        }
    }
    
    func getFavorites() -> [ImageData] {
        return cacheManager.getFavorites()
    }
    
    func saveFavorites(_ favorites: [ImageData]) {
        cacheManager.saveFavorites(favorites)
    }
    
    func isAlreadyFavorite(_ request: String) -> Bool {
        let favorites = getFavorites()
        if !favorites.contains(where: { $0.request == request }) {
            return false
        }
        return true
    }
    
    //MARK: - Private Methods
    
    private func removeOldestFavorite() {
        cacheManager.removeOldestFavorite()
        delegate?.updateFavoritesList(getFavorites())
    }
}
