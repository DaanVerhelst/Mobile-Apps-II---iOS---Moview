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
        
    var apiMovie: RecentMovie?
        
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var LanguageLabel: UILabel!
    @IBOutlet var OverviewLabel: UILabel!
    @IBOutlet var GenresLabel: UILabel!
    @IBOutlet var AdultLabel: UILabel!
    @IBOutlet var ReleaseDateLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let apiMovie = apiMovie {
            navigationItem.title = "Movie"
            TitleLabel.text = apiMovie.originalTitle
            LanguageLabel.text = apiMovie.originalLanguage
            GenresLabel.text = "Genre"
            if let adultMov = apiMovie.adult {
                AdultLabel.text = adultMov ? "Yes" : "No"
            }
            ReleaseDateLabel.text = apiMovie.releaseDate
        }
        }
}
