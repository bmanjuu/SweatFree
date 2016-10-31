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
    var location : Location?
    var RSVPEvents : [FitnessEvent]?
    
    init(zipcode: String, location: Location, RSVPEvents: [FitnessEvent]) {
        self.zipcode = zipcode
        self.location = location
        self.RSVPEvents = RSVPEvents
    }
    
    init(zipcode: String) {
        self.init(zipcode: zipcode, location: Location(), RSVPEvents: [FitnessEvent]())
    }
    
    init(location: Location) {
        self.init(zipcode: "user zipcode", location: location, RSVPEvents: [FitnessEvent]())
    }
    
    init() {
        self.init(zipcode: "user zipcode", location: Location(), RSVPEvents: [FitnessEvent]())
    }
    
}

