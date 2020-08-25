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
    
    let movieInfoController = MovieInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieInfoController.fetchPopularMovies(){
            (popularMovies) in
            if let popularMovies = popularMovies {
                self.updateUI(with: popularMovies)
            }
        }
    }
    
    func updateUI(with popularMovies: [APIMovie]){
        DispatchQueue.main.async {
            self.popularMovies = popularMovies
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularMovieIdentifier", for: indexPath) as! CustomCell
        
        let movie = popularMovies[indexPath.row]
        cell.title.text = movie.originalTitle
        if let path = movie.imagePath {
            movieInfoController.fetchImage(url: path){
                (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath {
                        return
                    }
                    
                    cell.imageViewCell?.image = image
                }
            }
        }
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


