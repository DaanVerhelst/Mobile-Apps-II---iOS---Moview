//
//  MyMovieListViewController.swift
//  Moview
//
//  Created by Gebruiker on 23/08/2020.
//  Copyright © 2020 Gebruiker. All rights reserved.
//

import Foundation
import UIKit

class MyMovieListViewController: UITableViewController {
    var movieItems = [MovieItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedMovies = MovieItem.loadMovieItems(){
            movieItems = savedMovies
        } else {
            movieItems = MovieItem.loadSampleMovieItems()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemCellIdentifier", for: indexPath)
        
        let movieItem = movieItems[indexPath.row]
        cell.textLabel?.text = movieItem.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            movieItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            MovieItem.saveMovieItems(movieItems)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func unwindToMovieItemList(segue: UIStoryboardSegue){
        
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! NewMovieItemTableViewController
        
        if let movieItem = sourceViewController.movieItem {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                movieItems[selectedIndexPath.row] = movieItem
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: movieItems.count, section: 0)
                movieItems.append(movieItem)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
        MovieItem.saveMovieItems(movieItems)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "EditMovieItem", let navController = segue.destination as? UINavigationController, let newMovieItemTableViewController = navController.topViewController as? NewMovieItemTableViewController {
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedMovieItem = movieItems[indexPath.row]
            newMovieItemTableViewController.movieItem = selectedMovieItem
        }
    }
}
