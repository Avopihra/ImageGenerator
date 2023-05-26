//
//  FavoritesService.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

protocol FavoritesServiceProtocol {
    
    func addFavorite(_ item: Favorite)
    
    func removeFavorite(atIndex index: Int)
    
    func getFavorites() -> [Favorite]
    
    func saveFavorites()
}

class FavoritesService: FavoritesServiceProtocol {
    
    private var favorites: [Favorite] = []
    private let maxFavoritesCount = 15
    private let favoritesKey = "Favorites"
    
    func addFavorite(_ item: Favorite) {
        if favorites.count >= maxFavoritesCount {
            favorites.removeFirst()
        }
        favorites.append(item)
        saveFavorites()
    }
    
    func removeFavorite(atIndex index: Int) {
        favorites.remove(at: index)
        saveFavorites()
    }
    
    func saveFavorites() {
        // Implement your favorite items persistence logic here
    }
    
    func getCachedImage(for request: String) -> UIImage? {
        
        if let data = UserDefaults.standard.data(forKey: favoritesKey + request),
           let image = UIImage(data: data) {
            return image
        }
        
        return nil
    }
    
    func getLastGeneratedImage() -> UIImage? {
        
        if let data = UserDefaults.standard.data(forKey: favoritesKey + "lastGeneratedImage"),
           let image = UIImage(data: data) {
            return image
        }
        
        return nil
    }
    
    func getLastGeneratedRequest() -> String? {
        return UserDefaults.standard.string(forKey: favoritesKey + "lastGeneratedRequest")
    }
    
    func addToFavorites(image: UIImage, request: String) {
        var favorites = getFavorites()
        if favorites.count >= maxFavoritesCount {
            removeOldestFavorite()
        }
        
        let data = image.jpegData(compressionQuality: 1.0)
        UserDefaults.standard.set(data, forKey: favoritesKey + request)
        
        // Update the last generated image and request
        UserDefaults.standard.set(data, forKey: favoritesKey + "lastGeneratedImage")
        UserDefaults.standard.set(request, forKey: favoritesKey + "lastGeneratedRequest")
        
        favorites.append(Favorite(data: data, request: request))
        saveFavorites(favorites)
    }
    
        func getFavorites() -> [Favorite] {
        guard let favoritesData = UserDefaults.standard.data(forKey: favoritesKey) else {
            return []
        }
        
        let decoder = JSONDecoder()
        if let favorites = try? decoder.decode([Favorite].self, from: favoritesData) {
            return favorites
        }
        
        return []
    }
    
    private func removeOldestFavorite() {
        var favorites = getFavorites()
        if let oldestFavorite = favorites.first {
            UserDefaults.standard.removeObject(forKey: favoritesKey + oldestFavorite.request)
        }
        
        favorites.removeFirst()
        saveFavorites(favorites)
    }
    
    func saveFavorites(_ favorites: [Favorite]) {
        let encoder = JSONEncoder()
        if let favoritesData = try? encoder.encode(favorites) {
            UserDefaults.standard.set(favoritesData, forKey: favoritesKey)
        }
    }
    
}
