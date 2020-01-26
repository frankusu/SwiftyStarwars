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
    var selectedItem = [String]()
    var filmName = ""
    
    let filmArray = ["A new hope", "Attack of the Clones", "The phatom menance", "Revenge of the Sith","Return of the Jedi","The Empire Strikes Back","The Force Awakens"]
    let detailFiller = ["S","T","A","R","W","A","R"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Films"
        tableView.register(SubtitleViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = filmArray[indexPath.row]
        cell.detailTextLabel?.text = detailFiller[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected index \(indexPath.row)")
        navigationController?.pushViewController(FilmDetailController(), animated: true)
        
    }

}

