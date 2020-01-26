//
//  MetadataController.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-25.
//  Copyright © 2020 frankusu. All rights reserved.
//

import UIKit

class FilmDetailController: UITableViewController {

    fileprivate let cellId = "category"
    
    let categories = ["LukeSkywalker","Yoda Boi"," Obi wan my true one","Chubaka","Piew piew",]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Film Detail"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailController(), animated: true)
    }

}
