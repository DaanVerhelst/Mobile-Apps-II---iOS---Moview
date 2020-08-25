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
    let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    let baseImageURL = URL(string: "https://image.tmdb.org/t/p/w500")!
    
    func fetchPopularMovies(completion: @escaping ([APIMovie]?) -> Void){
        let initialPopularMovieURL = baseURL.appendingPathComponent("movie/top_rated")
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
    
    func fetchRecentMovies(completion: @escaping ([APIMovie]?) -> Void){
        let initialRecentMovieURL = baseURL.appendingPathComponent("movie/now_playing")
        var components = URLComponents(url: initialRecentMovieURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "api_key", value: "a54fa8419cf0ff739faf7c9b9263eda1"), URLQueryItem(name: "language", value: "en-US")]
        let recentURL = components.url!
        let task = URLSession.shared.dataTask(with: recentURL){
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
    
    func fetchGenreList(completion: @escaping ([Genre]?) -> Void){
        let initiatGenreListURL = baseURL.appendingPathComponent("genre/movie/list")
        var components = URLComponents(url: initiatGenreListURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "api_key", value: "a54fa8419cf0ff739faf7c9b9263eda1"), URLQueryItem(name: "language", value: "en-US")]
        let genreURL = components.url!
        let task = URLSession.shared.dataTask(with: genreURL){
            (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let result = try? decoder.decode(Genres.self, from: data){
                completion(result.genres)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchImage(url: String, completion: @escaping (UIImage?) -> Void) {
        let intialImageURL = baseImageURL.appendingPathComponent(url)
        let components = URLComponents(url: intialImageURL, resolvingAgainstBaseURL: true)!
        let imageURL = components.url!
        let task = URLSession.shared.dataTask(with: imageURL){
            (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
