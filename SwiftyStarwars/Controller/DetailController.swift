//
//  DetailController.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-25.
//  Copyright © 2020 frankusu. All rights reserved.
//

import UIKit
class DetailController: UITableViewController {

    let starwars = "Starwars".map{String($0)}
    fileprivate let cellId = "detailCell"
    
    var detailUrl : String = "Nothing yet"
    var detailArray = [String]()
    var section : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
//        fetchPlanet()
        switch section {
        case 1:
            print("fetchCharacterDetail")
            fetchCharacterDetail()
        case 2:
            print("fetchPlanetDetail")
            fetchPlanetDetail()
        case 3:
            print("fetchStarshipDetail")
            fetchStarshipDetail()
        case 4:
            print("fetchVehicleDetail")
            fetchVehicleDetail()
        case 5:
            print("fetchSpecieDetail")
            fetchSpecieDetail()
        default:
            print("Invalid section selected no action required.")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = detailArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DetailController {
    
    func fetchCharacterDetail() {
        Service.shared.fetchCharacterDetail(url: detailUrl) { (result, error) in
            for (key,value) in result!.dict {
                self.detailArray.append("\(key) : \(value)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchPlanetDetail() {
        Service.shared.fetchPlanetDetail(url: detailUrl) { (result, error) in
            for (key,value) in result!.dict {
                self.detailArray.append("\(key) : \(value)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchStarshipDetail() {
        Service.shared.fetchStarshipDetail(url: detailUrl) { (result, error) in
            for (key,value) in result!.dict {
                self.detailArray.append("\(key) : \(value)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchVehicleDetail() {
        Service.shared.fetchVehicleDetail(url: detailUrl) { (result, error) in
            for (key,value) in result!.dict {
                self.detailArray.append("\(key) : \(value)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchSpecieDetail() {
        Service.shared.fetchSpecieDetail(url: detailUrl) { (result, error) in
            for (key,value) in result!.dict {
                self.detailArray.append("\(key) : \(value)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

