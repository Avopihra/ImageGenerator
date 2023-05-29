//
//  FavoritesService.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

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
    private let favoritesKey = "Favorites"
    
    var delegate: FavoriteViewDelegate?
    
    func removeFavorite(at index: Int) {
        var favorites = getFavorites()
        favorites.remove(at: index)
        saveFavorites(favorites)
    }
    
    func addToFavorites(image: UIImage, request: String) {
        var favorites = getFavorites()
        if favorites.count >= maxFavoritesCount {
            removeOldestFavorite()
            favorites = getFavorites()
        }
        
        let data = image.jpegData(compressionQuality: 1.0)
        UserDefaults.standard.set(data, forKey: favoritesKey + request)
        
        // Update the last generated image and request
        UserDefaults.standard.set(data, forKey: favoritesKey + "lastGeneratedImage")
        UserDefaults.standard.set(request, forKey: favoritesKey + "lastGeneratedRequest")
        
        let newFavorite = ImageData(data: data, request: request, isFavorite: true)
        
        // Check if the new favorite already exists in favorites
        if !favorites.contains(where: { $0.data == data && $0.request == request }) {
            favorites.append(newFavorite)
            self.saveFavorites(favorites)
            self.delegate?.updateFavoritesList(favorites)
        }
    }
    
    func getFavorites() -> [ImageData] {
        guard let favoritesData = UserDefaults.standard.data(forKey: favoritesKey) else {
            return []
        }
        
        let decoder = JSONDecoder()
        if let favorites = try? decoder.decode([ImageData].self, from: favoritesData) {
            return favorites
        }
        
        return []
    }
    
    func saveFavorites(_ favorites: [ImageData]) {
        let encoder = JSONEncoder()
        if let favoritesData = try? encoder.encode(favorites) {
            UserDefaults.standard.set(favoritesData, forKey: favoritesKey)
        }
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
        var favorites = getFavorites()
        if let oldestFavorite = favorites.first {
            UserDefaults.standard.removeObject(forKey: favoritesKey + oldestFavorite.request)
        }
        favorites.removeFirst()
        self.saveFavorites(favorites)
        self.delegate?.updateFavoritesList(favorites)
    }
}
