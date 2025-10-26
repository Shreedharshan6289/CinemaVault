//
//  FavouritesManager.swift
//  CinemaVault
//
//  Created by Apple on 26/10/25.
//

import Foundation

class FavouritesManager {
    
    static let shared = FavouritesManager()
    private let key = "favouriteMovies"
    
    private init() {}
    
    func addFavourite(movieID: Int) {
        var current = getFavourites()
        if !current.contains(movieID) {
            current.append(movieID)
        }
        saveFavourites(current)
    }
    
    func removeFavourite(movieID: Int) {
        var current = getFavourites()
        current.removeAll { $0 == movieID }
        saveFavourites(current)
    }
    
    func isFavourite(movieID: Int) -> Bool {
        let current = getFavourites()
        return current.contains(movieID)
    }
    
    func getFavourites() -> [Int] {
        return UserDefaults.standard.array(forKey: key) as? [Int] ?? []
    }
    
    private func saveFavourites(_ ids: [Int]) {
        UserDefaults.standard.set(ids, forKey: key)
    }
}
