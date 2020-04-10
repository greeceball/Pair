//
//  PairsTableViewController.swift
//  RandomizedPairs
//
//  Created by Colby Harris on 4/10/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class PairsTableViewController: UITableViewController {

    //MARK: - Properties
    var people: [Person] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var pairs: [Int] = []
    
    //MARK: - Lifecycle Func's
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func randomizeButtonTapped(_ sender: Any) {
        
    }
    
    //MARK: - Helper Func's
    func loadPeople() {
        self.people = PairsController.shared.peopleArray
    }
    
    func addPersonAlert() {
        
    }
    
    func generateRandomPairs() -> [Int] {
        for num in 0..<people.count {
            self.pairs.append(num)
        }
        return pairs
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PairsController.shared.peopleArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let person = PairsController.shared.peopleArray[indexPath.row]
        cell.textLabel?.text = person.name
        
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let personToDelete = people[indexPath.row]
            PairsController.shared.deletePerson(person: personToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
