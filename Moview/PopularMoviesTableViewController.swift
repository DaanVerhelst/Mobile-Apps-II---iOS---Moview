//
//  PopularMoviesTableViewController.swift
//  Moview
//
//  Created by Gebruiker on 23/08/2020.
//  Copyright © 2020 Gebruiker. All rights reserved.
//

import Foundation
import UIKit

class PopularMoviesTableViewController: UITableViewController {
    
    var popularMovies = [APIMovie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedPopularMovies = APIMovie.loadPopularMovies() {
            popularMovies = savedPopularMovies
        } else {
            popularMovies = APIMovie.loadSampleMovies()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularMovieIdentifier", for: indexPath)
        
        let popularMovie = popularMovies[indexPath.row]
        cell.textLabel?.text = popularMovie.originalTitle
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController, let apiMovieDetailViewController = navController.topViewController as? APIMovieDetailViewController {
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedAPIMovie = popularMovies[indexPath.row]
            apiMovieDetailViewController.apiMovie = selectedAPIMovie
        }
    }
    
    @IBAction func unwindToPopularMovies(segue: UIStoryboardSegue){
        
    }
}
