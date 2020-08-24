//
//  APIMovie.swift
//  Moview
//
//  Created by Gebruiker on 23/08/2020.
//  Copyright © 2020 Gebruiker. All rights reserved.
//

import Foundation
import UIKit

struct APIMovie: Codable{
    var id: Int?
    var adult: Bool?
    var genres: [Int]?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var releaseDate: String?
    var imagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case genres = "genre_ids"
        case adult
        case overview
        case releaseDate = "release_date"
        case imagePath = "poster_path"
    }
    
    static func loadPopularMovies() -> [APIMovie]? {
        return nil
    }
    
    static func loadRecentMovies() -> [APIMovie]? {
        return nil
    }
    
    static func loadSampleMovies() -> [APIMovie] {
        let sample1 = APIMovie(id: 1, adult: false, genres: [200, 201, 202], originalLanguage: "en", originalTitle: "movie1", overview: "This is movie 1", releaseDate: "", imagePath: "")
        let sample2 = APIMovie(id: 2, adult: false, genres: [200, 201, 202], originalLanguage: "en", originalTitle: "movie2", overview: "This is movie 2", releaseDate: "", imagePath: "")
        let sample3 = APIMovie(id: 3, adult: false, genres: [200, 201, 202], originalLanguage: "en", originalTitle: "movie3", overview: "This is movie 3", releaseDate: "", imagePath: "")
        let sample4 = APIMovie(id: 4, adult: false, genres: [200, 201, 202], originalLanguage: "en", originalTitle: "movie4", overview: "This is movie 4", releaseDate: "", imagePath: "")
        
        return [sample1, sample2, sample3, sample4]
    }
}

struct APIMovies: Codable {
    let items: [APIMovie]
    
    enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}

struct RecentMovie: Codable {
    var id: Int?
    var adult: Bool?
    var genres: [Genre]
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var releaseDate: String?
    var imagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case genres = "genres"
        case adult
        case overview
        case releaseDate = "release_date"
        case imagePath = "poster_path"
    }
}

struct Genre: Codable {
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
