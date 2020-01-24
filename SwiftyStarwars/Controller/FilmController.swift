//
//  FilmController.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-23.
//  Copyright © 2020 frankusu. All rights reserved.
//

import UIKit

class FilmController: UITableViewController {
    
    let cellId = "filmCell"
    
    let filmArray = ["A new hope", "Attack of the Clones", "The phatom menance", "Revenge of the Sith","Return of the Jedi","The Empire Strikes Back","The Force Awakens"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Films"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = filmArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmArray.count
    }

}

