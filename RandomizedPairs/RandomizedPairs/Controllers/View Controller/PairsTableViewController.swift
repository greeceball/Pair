//
//  PairsTableViewController.swift
//  RandomizedPairs
//
//  Created by Colby Harris on 4/10/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class PairsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var pairs: [[Person]]?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        randomize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        randomize()
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func shuffleButtonTapped(_ sender: Any) {
        randomize()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Full Name"
            textField.autocapitalizationType = .words
            textField.autocorrectionType = .no
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let name = alertController.textFields?.first?.text, !name.isEmpty else {
                self.present(alertController, animated: true)
                return
            }
            PersonController.shared.addPerson(withName: name)
            self.randomize()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return pairs?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
            return "Group \(section + 1)"
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pairs?[section].count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let student = pairs?[indexPath.section][indexPath.row]
        cell.textLabel?.text = student?.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let person = pairs?[indexPath.section][indexPath.row]
                else { return }
            pairs?[indexPath.section].remove(at: indexPath.row)
            PersonController.shared.removePerson(person: person)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.randomize()
        }
    }
    
    // MARK: - Helper Functions
    func randomize() {
        pairs = PersonController.shared.makePairs()
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destination = segue.destination as? PersonDetailViewController
                else {
                    print("Error in segue to detailVC")
                    return
            }
            destination.person = pairs?[indexPath.section][indexPath.row]
        }
    }
}
