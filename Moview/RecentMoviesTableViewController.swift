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
    var recentMovies = [RecentMovie]()
    
    let movieInfoController = MovieInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieInfoController.fetchRecentMovies(){
            (recentMovies) in
            if let recentMovies = recentMovies {
                self.updateUI(with: recentMovies)
            }
        }
    }
    
    func updateUI(with recentMovies: [RecentMovie]){
        DispatchQueue.main.async {
            self.recentMovies = recentMovies
            self.tableView.reloadData()
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
        if let navController = segue.destination as? UINavigationController, let recentMoviesDetailViewController = navController.topViewController as? RecentMoviesDetailViewController {
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedAPIMovie = recentMovies[indexPath.row]
            recentMoviesDetailViewController.apiMovie = selectedAPIMovie
        }
    }
    
    @IBAction func unwindToPopularMovies(segue: UIStoryboardSegue){
        
    }
}
