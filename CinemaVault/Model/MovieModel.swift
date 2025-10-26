//
//  MovieModel.swift
//  CinemaVault
//
//  Created by Apple on 26/10/25.
//

struct Movie {
    var id: String?
    var title: String?
    var posterPath: String?
    var releaseDate: String?
    var rating: Double?
    
    init(_ dict: [String: AnyObject]) {
        if let id = dict["id"] as? Int { self.id = "\(id)" }
        if let title = dict["title"] as? String { self.title = title }
        if let poster = dict["poster_path"] as? String { self.posterPath = poster }
        if let release = dict["release_date"] as? String { self.releaseDate = release }
        if let rating = dict["vote_average"] as? Double { self.rating = rating }
    }
}

