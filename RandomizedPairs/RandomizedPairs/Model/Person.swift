//
//  Person.swift
//  RandomizedPairs
//
//  Created by Colby Harris on 4/10/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import Foundation

class Person: Codable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
