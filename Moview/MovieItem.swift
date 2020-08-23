//
//  MovieItem.swift
//  Moview
//
//  Created by Gebruiker on 23/08/2020.
//  Copyright © 2020 Gebruiker. All rights reserved.
//

import Foundation
import UIKit

struct MovieItem: Codable{
    var title: String
    var watched: Bool
    var recommendedOn: Date
    var description: String?
    var genre: String?
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("movieItems").appendingPathExtension("plist")
    
    static func loadMovieItems() -> [MovieItem]? {
        guard let codedMovieItems = try? Data(contentsOf: ArchiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<MovieItem>.self, from: codedMovieItems)
    }
    
    static func saveMovieItems(_ movieItems: [MovieItem]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedMovieItems = try? propertyListEncoder.encode(movieItems)
        try? codedMovieItems?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static func loadSampleMovieItems() -> [MovieItem] {
        let movieItem1 = MovieItem(title: "Movie 1", watched: false, recommendedOn: Date(), description: "desc1", genre: "Horror")
        let movieItem2 = MovieItem(title: "Movie 2", watched: false, recommendedOn: Date(), description: "desc2", genre: "Comedy")
        let movieItem3 = MovieItem(title: "Movie 3", watched: false, recommendedOn: Date(), description: "desc3", genre: "Action")
        let movieItem4 = MovieItem(title: "Movie 4", watched: false, recommendedOn: Date(), description: "desc4", genre: "Romantic")
        
        return [movieItem1, movieItem2, movieItem3, movieItem4]
    }
    
    static let recommendedOnFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    
    
}
