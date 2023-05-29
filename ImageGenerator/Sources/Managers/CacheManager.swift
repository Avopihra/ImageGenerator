//
//  CacheManager.swift
//  ImageGenerator
//
//  Created by Viktoriya on 29.05.2023.
//

import Foundation
import UIKit
import SQLite

class CacheManager {
    
    private var database: Connection?
    private let cacheTable = Table("cache")
    private let id = Expression<Int64>("id")
    private let text = Expression<String>("text")
    private let imageData = Expression<Data?>("imageData")

    init() {
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("cache.sqlite")
            database = try Connection(fileURL.path)
            createCacheTableIfNeeded()
        } catch {
            print("Error opening database: \(error)")
        }
    }
    
    //MARK: - Private Methods
    private func createCacheTableIfNeeded() {
        do {
            try database?.run(cacheTable.create(ifNotExists: true) { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(text)
                table.column(imageData)
            })
        } catch {
            print("Error creating cache table: \(error)")
        }
    }
    
    //MARK: - Manager`s Methods

    func saveFavorites(_ favorites: [ImageData]) {
            do {
                try database?.transaction {
                    for favorite in favorites {
                        let insert = cacheTable.insert(text <- favorite.request, imageData <- favorite.data)
                        try database?.run(insert)
                    }
                }
            } catch {
                print("Error saving favorites to cache: \(error)")
            }
        }

    func removeFavorite(request: String) {
            do {
                try database?.run(cacheTable.filter(text == request).delete())
            } catch {
                print("Error removing favorite from cache: \(error)")
            }
        }
    
     func removeOldestFavorite() {
        do {
            let oldestFavorite = try database?.pluck(cacheTable.order(text))
            if let request = oldestFavorite?[text] {
                try database?.run(cacheTable.filter(text == request).delete())
            }
        } catch {
            print("Error removing oldest favorite from cache: \(error)")
        }
    }

    func getFavorites() -> [ImageData] {
        do {
            guard let rows = try database?.prepare(cacheTable) else {
                return []
            }
            
            var favorites: [ImageData] = []
            var uniqueRequests = Set<String>()
            
            for row in AnySequence(rows) {
                let request = row[text]
                
                guard !uniqueRequests.contains(request) else {
                    continue
                }
                
                let imageData = ImageData(data: row[imageData], request: request, isFavorite: true)
                favorites.append(imageData)
                uniqueRequests.insert(request)
            }
            
            return favorites
        } catch {
            print("Error retrieving from cache: \(error)")
        }
        
        return []
    }

}
