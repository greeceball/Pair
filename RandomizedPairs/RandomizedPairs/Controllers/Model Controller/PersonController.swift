//
//  PairsController.swift
//  RandomizedPairs
//
//  Created by Colby Harris on 4/10/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    // MARK: - Properties
    
    static let shared = PersonController()
    
    var peopleArray: [Person] {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    // MARK: - CRUD
    
    func addPerson(withName name: String) {
        _ = Person(name: name)
        saveToPersistentStore()
    }
    
    func update(person: Person, withName name: String) {
        person.name = name
        saveToPersistentStore()
    }
    
    func removePerson(person: Person) {
        CoreDataStack.context.delete(person)
        saveToPersistentStore()
    }
    
    // MARK: - Helper Methods
    
    //    func makePairs() -> [[Person]] {
    //        let shuffledPersons = peopleArray.shuffled()
    //
    //        var pairs = [[Person]]()
    //        var pair = [Person]()
    //
    //        for person in shuffledPersons {
    //            if pair.count == 0 {
    //                pair.append(person)
    //            } else {
    //                pair.append(person)
    //                pairs.append(pair)
    //                pair = [Person]()
    //            }
    //        }
    //
    //
    //        if pair.count != 0 {
    //            pairs.append(pair)
    //        }
    //
    //        return pairs
    //    }
    
    func makePairs() -> [[Person]] {
        
        let randomized = peopleArray.shuffled()
        var singlePair = [Person]()
        var multiplePairs = [[Person]]()
        for person in randomized {
            if singlePair.count == 0 {
                singlePair.append(person)
            } else {
                singlePair.append(person)
                multiplePairs.append(singlePair)
                singlePair = [Person]()
            }
        }
        if singlePair.count != 0 {
            multiplePairs.append(singlePair)
        }
        return multiplePairs
        
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            print("Error! I ran into a problem at the persistent store... Sorry, couldn't save! \(error.localizedDescription)")
        }
    }
    
}
