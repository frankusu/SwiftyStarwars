//
//  MetadataController.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-25.
//  Copyright © 2020 frankusu. All rights reserved.
//

import UIKit
enum Starwars : Int {
    case details = 0
    case characters = 1
    case planets = 2
    case starships = 3
    case vehicles = 4
    case species = 5
}
class FilmDetailController: UITableViewController {

    fileprivate let cellId = "category"
    fileprivate var setExpand = true
    fileprivate let categoryHeader = ["Details","Characters","Planets","Starships","Vehicles","Species"]
    
    //TODO: Put these into dictionary like [url: String, name : String, detailUrl : String]
    // let filmDetailObject = [url: String, name : String, detailUrl : String]
    // let filmDetailObjects = [filmDetailObject]
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
    
    var charactersDetailUrl = [String]()
    var planetsDetailUrl = [String]()
    var starshipsDetailUrl = [String]()
    var vehiclesDetailUrl = [String]()
    var speciesDetailUrl = [String]()
    
    // To create expandable table sections
    lazy var twoDimensionArray = [
        ExpandedFilm(isExpanded: false, info: filmDetails),
        ExpandedFilm(isExpanded: setExpand, info: characters),
        ExpandedFilm(isExpanded: setExpand, info: planets),
        ExpandedFilm(isExpanded: setExpand, info: starships),
        ExpandedFilm(isExpanded: setExpand, info: vehicles),
        ExpandedFilm(isExpanded: setExpand, info: species)
    ]
    //TODO: Make url a dictionary part of names array so don't need to duplicate
    lazy var twoDimensionUrl = [
        ExpandedFilm(isExpanded: setExpand, info: []),
        ExpandedFilm(isExpanded: setExpand, info: charactersDetailUrl),
        ExpandedFilm(isExpanded: setExpand, info: planetsDetailUrl),
        ExpandedFilm(isExpanded: setExpand, info: starshipsDetailUrl),
        ExpandedFilm(isExpanded: setExpand, info: vehiclesDetailUrl),
        ExpandedFilm(isExpanded: setExpand, info: speciesDetailUrl)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Film Detail"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        fetchAllData()
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton()
        print("Section", section)
        let category = categoryHeader[section]
        button.setTitle(category, for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.yellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        return button
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = twoDimensionArray[indexPath.section].info[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionArray[section].isExpanded {
            return 0
        }
        return twoDimensionArray[section].info.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailController()
        if indexPath.section == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            print("Section: \(indexPath.section) Row: \(indexPath.row)")
            detailController.detailUrl = twoDimensionUrl[indexPath.section].info[indexPath.row]
            detailController.section = indexPath.section
            // Make sure to pass in declared controller, other wise value won't pass in
            navigationController?.pushViewController(detailController, animated: true)
        }
        
    }
}
extension FilmDetailController {
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

    //TODO: Refactor please
    //TODO: Use enum to add error handling message
    func fetchAllData() {
        let dispatchGroup = DispatchGroup()
        
        for url in charactersUrl {
            dispatchGroup.enter()
            Service.shared.fetchCharacter(url: url) { (result, error) in
                dispatchGroup.leave()
                guard let result = result else {return}
                self.characters.append(result.name)
                self.charactersDetailUrl.append(result.url)
            }
        }
        for url in planetsUrl {
            dispatchGroup.enter()
            Service.shared.fetchPlanet(url: url) { (result, error) in
                dispatchGroup.leave()
                guard let result = result else {return}
                self.planets.append(result.name)
                self.planetsDetailUrl.append(result.url)
            }
        }
        
        for url in starshipsUrl {
            dispatchGroup.enter()
            Service.shared.fetchStarship(url: url) { (result, error) in
                dispatchGroup.leave()
                guard let result = result else {return}
                self.starships.append(result.name)
                self.starshipsDetailUrl.append(result.url)
            }
        }
        
        for url in vehiclesUrl {
            dispatchGroup.enter()
            Service.shared.fetchVehicle(url: url) { (result, error) in
                dispatchGroup.leave()
                guard let result = result else {return}
                self.vehicles.append(result.name)
                self.vehiclesDetailUrl.append(result.url)
            }
        }
        
        for url in speciesUrl {
            dispatchGroup.enter()
            Service.shared.fetchSpecie(url: url) { (result, error) in
                dispatchGroup.leave()
                guard let result = result else {return}
                self.species.append(result.name)
                self.speciesDetailUrl.append(result.url)
            }
        }

        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("Successfully retrieved all data")
            // Update twoDimensionArray for tableView.reloadData to reload
            self.twoDimensionArray[Starwars.details.rawValue] = ExpandedFilm(isExpanded: self.setExpand, info: self.filmDetails)
            self.twoDimensionArray[Starwars.characters.rawValue] = ExpandedFilm(isExpanded: self.setExpand, info: self.characters)
            self.twoDimensionArray[Starwars.planets.rawValue] = ExpandedFilm(isExpanded: self.setExpand, info: self.planets)
            self.twoDimensionArray[Starwars.starships.rawValue] = ExpandedFilm(isExpanded: self.setExpand, info: self.starships)
            self.twoDimensionArray[Starwars.vehicles.rawValue] = ExpandedFilm(isExpanded: self.setExpand, info: self.vehicles)
            self.twoDimensionArray[Starwars.species.rawValue] = ExpandedFilm(isExpanded: self.setExpand, info: self.species)
            self.tableView.reloadData()
        }
    }
}
