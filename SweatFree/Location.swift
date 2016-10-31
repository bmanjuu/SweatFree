//
//  Location.swift
//  SweatFree
//
//  Created by Betty Fung on 10/31/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation

struct Location {
    
    var name : String
    var coordinates : (latitude: Double, longitude: Double)
    var description : String
    
    init(name: String, coordinates: (latitude: Double, longitude: Double), description: String) {
        self.name = name
        self.coordinates = coordinates
        self.description = description
    }
    
    init(coordinates: (latitude: Double, longitude: Double)) {
        self.init(name: "location name", coordinates: coordinates, description: "location description")
    }
    
    init() {
        //default coordinates = latitude: 40.700454, longitude: -73.996657
        self.init(name: "location name", coordinates: (latitude: 40.700454, longitude: -73.996657), description: "location description")
    }
    
}
