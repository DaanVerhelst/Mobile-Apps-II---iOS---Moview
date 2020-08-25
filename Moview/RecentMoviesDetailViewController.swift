//
//  RecentMoviesDetailViewController.swift
//  Moview
//
//  Created by Gebruiker on 24/08/2020.
//  Copyright © 2020 Gebruiker. All rights reserved.
//

import Foundation
import UIKit

class RecentMoviesDetailViewController: UIViewController {
        
    var apiMovie: APIMovie?
    
    let movieInfoController = MovieInfoController()
    
    var applicableGenreStrings = [String]()
    
    var genreList: [Genre]?
        
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var LanguageLabel: UILabel!
    @IBOutlet var OverviewLabel: UILabel!
    @IBOutlet var GenresLabel: UILabel!
    @IBOutlet var AdultLabel: UILabel!
    @IBOutlet var ReleaseDateLabel: UILabel!
    
    var imagePath: String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let apiMovie = apiMovie {
            navigationItem.title = "Movie"
            TitleLabel.text = apiMovie.originalTitle
            LanguageLabel.text = apiMovie.originalLanguage
            OverviewLabel.text = apiMovie.overview
            movieInfoController.fetchGenreList(){
                (genreList) in
                if let genreList = genreList, let apiGenres = apiMovie.genres {
                    for apiGenre in apiGenres {
                        for genreItem in genreList {
                            if apiGenre == genreItem.id {
                                if let genreName = genreItem.name {
                                    self.applicableGenreStrings.append(genreName)
                                }
                            }
                        }
                    }
                }
                
                self.UpdateGenre(with: self.applicableGenreStrings)
            }
            
            if let adultMov = apiMovie.adult {
                AdultLabel.text = adultMov ? "Yes" : "No"
            }
            ReleaseDateLabel.text = apiMovie.releaseDate
            if let imagePath = apiMovie.imagePath {
                self.imagePath = imagePath
                print(imagePath)
            }
            
            if let path = apiMovie.imagePath {
                movieInfoController.fetchImage(url: path){
                    (image) in
                    if let image = image {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                            
                        }
                    }
                }
            }
        }
    }
    
    func UpdateGenre(with applicableGenreStrings: [String]){
        DispatchQueue.main.async {
            self.GenresLabel.text = applicableGenreStrings.joined(separator: ", ")
        }
    }
}
