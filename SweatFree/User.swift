//
//  User.swift
//  SweatFree
//
//  Created by Betty Fung on 10/21/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation

struct User {
    
    var zipcode : String
    var coordinates : (latitude: Double, longitude: Double)?
    var RSVPEvents : [FitnessEvent]?
    
    init(zipcode: String, coordinates: (Double, Double), RSVPEvents: [FitnessEvent]) {
        self.zipcode = zipcode
        self.coordinates = coordinates
        self.RSVPEvents = RSVPEvents
    }
    
    init(zipcode: String) {
        self.init(zipcode: zipcode, coordinates: (0.00, 0.00), RSVPEvents: [])
    }
    
}

