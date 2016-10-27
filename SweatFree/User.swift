//
//  User.swift
//  SweatFree
//
//  Created by Betty Fung on 10/21/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation

struct User {
    
    var address : String
    var coordinates : (latitude: Double, longitude: Double)?
    var RSVPEvents : [FitnessEvent]?
    
    init(address: String, coordinates: (Double, Double), RSVPEvents: [FitnessEvent]) {
        self.address = address
        self.coordinates = coordinates
        self.RSVPEvents = RSVPEvents
    }
    
    init(address: String) {
        self.init(address: address, coordinates: (0.00, 0.00), RSVPEvents: [])
    }
    
}

