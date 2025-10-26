//
//  MovieDetailsModel.swift
//  CinemaVault
//
//  Created by Apple on 26/10/25.
//

import Foundation


struct MovieDetails {
    var title: String?
    var releaseDate: String?
    var runtime: Int?
    var genres: [String] = []
    var overview: String?
    var voteAverage: Double?
    var posterPath: String?
    
    init(_ dict: [String: AnyObject]) {
        self.title = dict["title"] as? String
        self.releaseDate = dict["release_date"] as? String
        self.runtime = dict["runtime"] as? Int
        self.overview = dict["overview"] as? String
        if let vote = dict["vote_average"] {
            self.voteAverage = Double("\(vote)") ?? 0.0
        }
        if let poster = dict["poster_path"] as? String {
            self.posterPath = "https://image.tmdb.org/t/p/w500\(poster)"
        }
        if let genresArr = dict["genres"] as? [[String: AnyObject]] {
            self.genres = genresArr.compactMap { $0["name"] as? String }
        }
    }
}

struct MovieVideo {
    var name: String?
    var key: String?
    var site: String?
    var type: String?
    
    init(_ dict: [String: AnyObject]) {
        self.name = dict["name"] as? String
        self.key = dict["key"] as? String
        self.site = dict["site"] as? String
        self.type = dict["type"] as? String
    }
}

struct CastMember {
    var name: String?
    var character: String?
    var profilePath: String?
    
    init(_ dict: [String: AnyObject]) {
        self.name = dict["name"] as? String
        self.character = dict["character"] as? String
        if let path = dict["profile_path"] as? String {
            self.profilePath = "https://image.tmdb.org/t/p/w200\(path)"
        }
    }
}
