//
//  NewMovieItemTableViewController.swift
//  Moview
//
//  Created by Gebruiker on 23/08/2020.
//  Copyright © 2020 Gebruiker. All rights reserved.
//

import Foundation
import UIKit

class NewMovieItemTableViewController: UITableViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var watchedButton: UIButton!
    @IBOutlet var genreTextField: UITextField!
    @IBOutlet var recommendedOnLabel: UILabel!
    @IBOutlet var recommendedOnDatePickerView: UIDatePicker!
    @IBOutlet var descriptionTextView: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var isPickerHidden = true
    
    var movieItem: MovieItem?
    
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let descriptionViewIndexPath = IndexPath(row: 0, section: 2)
    
    let normalCellHeight: CGFloat = 44
    let largeCellHeight: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movieItem = movieItem {
            navigationItem.title = "Movie"
            titleTextField.text = movieItem.title
            genreTextField.text = movieItem.genre
            watchedButton.isSelected = movieItem.watched
            recommendedOnDatePickerView.date = movieItem.recommendedOn
            descriptionTextView.text = movieItem.description
        } else {
            recommendedOnDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        
        updateRecommendedOnLabel(date: recommendedOnDatePickerView.date)
        updateSaveButtonState()
    }
    
    func updateSaveButtonState(){
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func updateRecommendedOnLabel(date: Date){
        recommendedOnLabel.text = MovieItem.recommendedOnFormatter.string(from: date)
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func watchedButtonTapped(_ sender: UIButton) {
        watchedButton.isSelected = !watchedButton.isSelected
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateRecommendedOnLabel(date: recommendedOnDatePickerView.date)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return isPickerHidden ? 0 : recommendedOnDatePickerView.frame.height
        case descriptionViewIndexPath:
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dateLabelIndexPath {
            isPickerHidden = !isPickerHidden
            recommendedOnLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let genre = genreTextField.text
        let watched = watchedButton.isSelected
        let recommendedOn = recommendedOnDatePickerView.date
        let description = descriptionTextView.text
        
        movieItem = MovieItem(title: title, watched: watched, recommendedOn: recommendedOn, description: description, genre:  genre)
    }
    
}
