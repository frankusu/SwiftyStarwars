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
    
    // Probably can reduce these or put them in model object
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
    
    // To create expandable table sections
    lazy var twoDimensionArray = [
        ExpandedFilm(isExpanded: false, info: filmDetails),
        ExpandedFilm(isExpanded: setExpand, info: characters),
        ExpandedFilm(isExpanded: setExpand, info: planets),
        ExpandedFilm(isExpanded: setExpand, info: starships),
        ExpandedFilm(isExpanded: setExpand, info: vehicles),
        ExpandedFilm(isExpanded: setExpand, info: species)
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
        let detail = twoDimensionArray[indexPath.section].info[indexPath.row]
        
        navigationController?.pushViewController(DetailController(), animated: true)
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
    func fetchAllData() {
        let dispatchGroup = DispatchGroup()
        
        for (index,url) in charactersUrl.enumerated() {
            dispatchGroup.enter()
            Service.shared.fetchCharacter(url: url) { (result, error) in
                dispatchGroup.leave()
                print("Index \(index) :\(result!.name)")
                self.characters.append(result!.name)
            }
        }
        for (index,url) in planetsUrl.enumerated() {
            dispatchGroup.enter()
            Service.shared.fetchPlanet(url: url) { (result, error) in
                dispatchGroup.leave()
                print("Index \(index) :\(result!.name)")
                self.planets.append(result!.name)
            }
        }
        
        for (index,url) in starshipsUrl.enumerated() {
            dispatchGroup.enter()
            Service.shared.fetchStarship(url: url) { (result, error) in
                dispatchGroup.leave()
                print("Index \(index) :\(result!.name)")
                self.starships.append(result!.name)
            }
        }
        
        for (index,url) in vehiclesUrl.enumerated() {
            dispatchGroup.enter()
            Service.shared.fetchVehicle(url: url) { (result, error) in
                dispatchGroup.leave()
                print("Index \(index) :\(result!.name)")
                self.vehicles.append(result!.name)
            }
        }
        
        for (index,url) in speciesUrl.enumerated() {
            dispatchGroup.enter()
            Service.shared.fetchSpecie(url: url) { (result, error) in
                dispatchGroup.leave()
                print("Index \(index) :\(result!.name)")
                self.species.append(result!.name)
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

// From Stackoverflow: How can I use Swift’s Codable to encode into a dictionary?
extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
