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
    
    func updateUI(with recentMovies: [APIMovie]){
        DispatchQueue.main.async {
            self.recentMovies = recentMovies
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentMovieIdentifier", for: indexPath) as! CustomCell

        let popularMovie = recentMovies[indexPath.row]
        cell.title?.text = popularMovie.originalTitle
        
        if let path = popularMovie.imagePath {
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
        if let navController = segue.destination as? UINavigationController, let recentMoviesDetailViewController = navController.topViewController as? RecentMoviesDetailViewController {
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedAPIMovie = recentMovies[indexPath.row]
            recentMoviesDetailViewController.apiMovie = selectedAPIMovie
        }
    }
    
    @IBAction func unwindToPopularMovies(segue: UIStoryboardSegue){
        
    }
}

class CustomCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
}
