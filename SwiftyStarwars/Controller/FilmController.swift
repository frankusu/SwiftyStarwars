//
//  FilmController.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-23.
//  Copyright © 2020 frankusu. All rights reserved.
//

import UIKit

class FilmController: UITableViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("Updating")
    }
    
    
    fileprivate let cellId = "filmCell"
    fileprivate var filmResults = [Film]()
    fileprivate var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Films"
        tableView.register(SubtitleViewCell.self, forCellReuseIdentifier: cellId)
        fetchFilms()
        
        searchController = ({
            let sc = UISearchController(searchResultsController: nil)
            sc.searchResultsUpdater = self
            sc.obscuresBackgroundDuringPresentation = false
            sc.searchBar.sizeToFit()
            tableView.tableHeaderView = sc.searchBar
            return sc
        })()
        definesPresentationContext =  true
    }
    
    func fetchFilms() {
        Service.shared.fetchData { (result, error) in
            if let error = error {
                print("Error fetchingFilms", error)
            }
            self.filmResults = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let film = filmResults[indexPath.row]
        cell.textLabel?.text = film.title
        cell.detailTextLabel?.text = "Episode: \(film.episodeId)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmResults.count
    }
    // Pass data forward using properties
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected index \(indexPath.row)")
        let filmDetailController = FilmDetailController()
        prepareData(filmDetail: self.filmResults[indexPath.row],dc: filmDetailController)
        navigationController?.pushViewController(filmDetailController, animated: true)
        
    }

}
extension FilmController {
    //TODO: Find a better way to make struct into array
    func prepareData(filmDetail: Film, dc : FilmDetailController) {
        var filmMeta = [String]()
        print("Prepare Data for ", filmDetail.title)
        filmMeta.append("Title: \(filmDetail.title)")
        filmMeta.append("Director: \(filmDetail.director)")
        filmMeta.append("Episode: \(filmDetail.episodeId)")
        filmMeta.append("Producer: \(filmDetail.producer)")
        filmMeta.append("Release Date: \(filmDetail.releaseDate)")
        
        dc.filmDetails = filmMeta
        dc.charactersUrl = filmDetail.characters
        dc.planetsUrl = filmDetail.planets
        dc.starshipsUrl = filmDetail.starships
        dc.vehiclesUrl = filmDetail.vehicles
        dc.speciesUrl = filmDetail.species

    }
}
