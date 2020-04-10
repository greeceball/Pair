//
//  PairsController.swift
//  RandomizedPairs
//
//  Created by Colby Harris on 4/10/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import Foundation

class PairsController {
    
    //MARK: - Shared instance
    static let shared = PairsController()

    //MARK: - Source of truth
    var peopleArray:[Person] = []

    init() {
        loadFromPersistentStorage()
    }
    
    
    
    //MARK: - Helper Func's
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let fileName = "pairs.json"
        let fullURL = documentsDirectory.appendingPathComponent(fileName)
        return fullURL
    }
    
    func addPerson(person: Person) {
        peopleArray.append(person)
        saveToPersistentStorage()
    }
    
    func deletePerson(person: Person) {
        guard let deletionIndex = peopleArray.firstIndex(of: person) else { return }
        peopleArray.remove(at: deletionIndex)
        saveToPersistentStorage()
    }
    
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            let jsonDecoder = JSONDecoder()
            let decodedData = try jsonDecoder.decode([Person].self, from: data)
            peopleArray = decodedData
        } catch let error {
            print("Error loading pairs \(error)")
        }
        
    }
    
    func saveToPersistentStorage () {
        
        let jsonEncoder = JSONEncoder()
        let people = self.peopleArray
        
        do {
            let data = try jsonEncoder.encode(people)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving people \(error)")
        }
        
        
    }
}
