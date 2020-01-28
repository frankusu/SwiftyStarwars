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
    fileprivate var setExpand = true
    fileprivate let categoryHeader = ["Details","Characters","Planets","Starships","Vehicles","Species"]
    
    //Probably can put these in a model object
    var filmPackage = [[String]]()
    var filmDetails = [String]()
    
    var charactersUrl = [String]()
    var planetsUrl = [String]()
    var starshipsUrl = [String]()
    var vehiclesUrl = [String]()
    var speciesUrl = [String]()
    
    var characters = [String]()
    var planets = [String]()
    var starships = [String]()
    var vehicles = [String]()
    var species = [String]()
    
    
    lazy var twoDimensionArray = [
        ExpandedFilm(isExpanded: setExpand, info: filmDetails),
        ExpandedFilm(isExpanded: setExpand, info: characters),
//        ExpandedFilm(isExpanded: setExpand, info: planets),
//        ExpandedFilm(isExpanded: setExpand, info: starships),
//        ExpandedFilm(isExpanded: setExpand, info: vehicles),
//        ExpandedFilm(isExpanded: setExpand, info: species)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Film Detail"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        fetchCharacter()
    }
    
    func fetchCharacter() {
        for url in charactersUrl {
            print("fetchCharacter",url)
        }
//        Service.shared.fetchCharacter(url: <#T##String#>, completion: <#T##(Character?, Error?) -> ()#>)
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton()
        print("Section", section)
        let category = categoryHeader[section]
        button.setTitle(category, for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        return button
    }
    
    @objc func handleExpandClose(button : UIButton) {
        let section = button.tag
        var indexPaths = [IndexPath]()
        for index in twoDimensionArray[section].info.indices {
            indexPaths.append(IndexPath(row: index, section: section))
        }
        let isExpanded = twoDimensionArray[section].isExpanded
        twoDimensionArray[section].isExpanded = !isExpanded
        button.setTitle(isExpanded ? "Expand" : "Collapse", for: .normal)
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = twoDimensionArray[indexPath.section].info[indexPath.row] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionArray[section].isExpanded {
            return 0
        }
        return twoDimensionArray[section].info.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailController(), animated: true)
    }

    
}
