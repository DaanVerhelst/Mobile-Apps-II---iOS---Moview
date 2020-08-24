//
//  MovieInfoController.swift
//  Moview
//
//  Created by Gebruiker on 24/08/2020.
//  Copyright © 2020 Gebruiker. All rights reserved.
//

import Foundation
import UIKit

class MovieInfoController {
    let baseURL = URL(string: "https://api.themoviedb.org/3/movie/")!
    
    func fetchPopularMovies(completion: @escaping ([APIMovie]?) -> Void){
        let initialPopularMovieURL = baseURL.appendingPathComponent("top_rated")
        var components = URLComponents(url: initialPopularMovieURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "api_key", value: "a54fa8419cf0ff739faf7c9b9263eda1"), URLQueryItem(name: "language", value: "en-US")]
        let popularURL = components.url!
        let task = URLSession.shared.dataTask(with: popularURL){
            (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let result = try? decoder.decode(APIMovies.self, from: data){
                completion(result.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchRecentMovies(completion: @escaping ([RecentMovie]?) -> Void){
        let initialRecentMovieURL = baseURL.appendingPathComponent("latest")
        var components = URLComponents(url: initialRecentMovieURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "api_key", value: "a54fa8419cf0ff739faf7c9b9263eda1"), URLQueryItem(name: "language", value: "en-US")]
        let recentURL = components.url!
        let task = URLSession.shared.dataTask(with: recentURL){
            (data, response, error) in
            let decoder = JSONDecoder()
            print(data)
            if let data = data,
                let result: [RecentMovie] = try? decoder.decode([RecentMovie].self, from: data){
                print(result)
                completion(result)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
