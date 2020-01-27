//
//  FilmController.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-23.
//  Copyright © 2020 frankusu. All rights reserved.
//

import UIKit

class FilmController: UITableViewController {
    
    fileprivate let cellId = "filmCell"
    fileprivate var filmResults = [Film]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Films"
        tableView.register(SubtitleViewCell.self, forCellReuseIdentifier: cellId)
        fetchFilms()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected index \(indexPath.row)")
        let filmDetailController = FilmDetailController()
        filmDetailController.filmDetails = self.filmResults
        navigationController?.pushViewController(filmDetailController, animated: true)
        
    }

}

