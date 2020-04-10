//
//  PersonDetailViewController.swift
//  RandomizedPairs
//
//  Created by Colby Harris on 4/10/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    // MARK: - Properties
    var person: Person?
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let student = person {
            nameTextField.text = student.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let newName = nameTextField.text, !newName.isEmpty,
            let person = person
            else { return }
        
        PersonController.shared.update(person: person, withName: newName)
        navigationController?.popViewController(animated: true)
    }

}
