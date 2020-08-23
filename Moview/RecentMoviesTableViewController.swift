//
//  RecentMoviesTableViewController.swift
//  Moview
//
//  Created by Gebruiker on 23/08/2020.
//  Copyright © 2020 Gebruiker. All rights reserved.
//

import Foundation
import UIKit

class RecentMoviesTableViewController: UITableViewController {
    var recentMovies = [APIMovie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedRecentMovies = APIMovie.loadRecentMovies() {
            recentMovies = savedRecentMovies
        } else {
            recentMovies = APIMovie.loadSampleMovies()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentMovieIdentifier", for: indexPath)
        
        let popularMovie = recentMovies[indexPath.row]
        cell.textLabel?.text = popularMovie.originalTitle
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController, let apiMovieDetailViewController = navController.topViewController as? APIMovieDetailViewController {
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedAPIMovie = recentMovies[indexPath.row]
            apiMovieDetailViewController.apiMovie = selectedAPIMovie
        }
    }
    
    @IBAction func unwindToPopularMovies(segue: UIStoryboardSegue){
        
    }
}
